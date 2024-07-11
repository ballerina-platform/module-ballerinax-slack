// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/lang.regexp;

type Specification record {
    map<Path> paths;
    Components components;
};

type Path record {
    Get get?;
    Post post?;
};

type Get record {
    string summary?;
    string description?;
    string[] tags?;
    map<ResponseCode> responses?;
};

type Post record {
    string summary?;
    string description?;
    string[] tags?;
    json requestBody?;
    map<ResponseCode> responses?;
};

type ResponseCode record {
    string description?;
    map<ResponseHeader> content?;
};

type ResponseHeader record {
    ResponseSchema schema?;
};

type ResponseSchema record {
    string title?;
    string 'type?;
    string schemaType?;
};

type Components record {
    map<json> schemas;
};

const SPEC_PATH = "openapi.json";
const CONTENT_TYPE_JSON = "application/json";
final regexp:RegExp MALFORMED_TITLE_REGEX = re `\w+[\.\s]\w+.*`;

public function main() returns error? {
    json openAPISpec = check io:fileReadJson(SPEC_PATH);
    Specification spec = check openAPISpec.cloneWithType(Specification);

    spec = check sanitizeResponseSchemaNames(spec);
    string sanitizedSpecString = sanitizeSchemaNames(spec);
    check io:fileWriteString(SPEC_PATH, sanitizedSpecString);
}

function sanitizeResponseSchemaNames(Specification spec) returns Specification|error {
    map<Path> paths = spec.paths;
    foreach var [_, value] in paths.entries() {
        map<ResponseCode>? responses = ();
        if value.get !is () {
            responses = value?.get?.responses;
        } else if value.post !is () {
            responses = value?.post?.responses;
        }

        if responses !is map<ResponseCode> {
            continue;
        }
        foreach [string, ResponseCode] [_, item] in responses.entries() {
            map<ResponseHeader> content = item.content ?: {};
            ResponseHeader app = content[CONTENT_TYPE_JSON] ?: {};
            ResponseSchema schema = app.schema ?: {};
            string? title = schema.title;
            if title !is string {
                continue;
            }

            // if the title is malformed, sanitize it by removing special characters and converting to pascal case
            if MALFORMED_TITLE_REGEX.isFullMatch(title) {
                string tempTitle = re `\.`.replaceAll(title, " ");
                string[] nameParts = re ` `.split(tempTitle);
                string[] capitalizedNameParts = from string namePart in nameParts
                    select namePart[0].toUpperAscii() + namePart.substring(1, namePart.length());

                string sanitizedTitle = string:'join("", ...capitalizedNameParts);
                sanitizedTitle = re `SuccessSchema`.replaceAll(sanitizedTitle, "Response");
                sanitizedTitle = re `Schema`.replaceAll(sanitizedTitle, "Response");
                schema.title = sanitizedTitle;
            }
        }
    }

    return spec;
}

function sanitizeSchemaNames(Specification spec) returns string {

    map<json> updatedSchemas = {};
    map<string> updatedNames = {};

    foreach [string, json] [schemaName, schema] in spec.components.schemas.entries() {
        if schemaName.includes("_") {
            string newName = getSanitizedSchemaName(schemaName);
            if updatedSchemas.hasKey(newName) {
                io:println("Error: Duplicate sanitized schema name found: " + newName + " for schema: " + schemaName);
            }
            updatedNames[schemaName] = newName;
            updatedSchemas[newName] = schema;
        } else {
            updatedSchemas[schemaName] = schema;
        }
    }
    spec.components.schemas = updatedSchemas;

    string updatedSpec = spec.toJsonString();
    foreach [string, string] [oldName, newName] in updatedNames.entries() {
        regexp:RegExp oldRegex = re `#/components/schemas/${oldName}"`;
        regexp:Replacement replacement = string `#/components/schemas/${newName}"`;
        updatedSpec = oldRegex.replaceAll(updatedSpec, replacement);
    }

    return updatedSpec;
}

function getSanitizedSchemaName(string schemaName) returns string {
    string[] nameParts = re `_`.split(schemaName);
    if nameParts[0] == "defs" {
        string _ = nameParts.remove(0);
        nameParts.push("Def");
    }

    if nameParts[0] == "objs" {
        string _ = nameParts.remove(0);
        nameParts.push("Obj");
    }

    string[] capitalizedNameParts = from string namePart in nameParts
        select namePart[0].toUpperAscii() + namePart.substring(1, namePart.length());
    return string:'join("", ...capitalizedNameParts);
}
