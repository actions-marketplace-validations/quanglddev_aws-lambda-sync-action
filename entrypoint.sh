#!/bin/bash
set -e

publish_dependencies_as_layer() {
    echo "Installing and zipping dependencies..."
    mkdir folder
    cd folder
    virtualenv v-env
    source ./v-env/bin/activate
    pip install -r ../requirements.txt
    deactivate
    mkdir python
    cd python
    cp -r ../v-env/lib/python3.7/site-packages/* .
    cd ..
    zip -r dependencies.zip python

    echo "Publishing dependencies as a layer..."
    local result=$(aws lambda publish-layer-version --layer-name "${INPUT_LAMBDA_LAYER_NAME}" --zip-file fileb://dependencies.zip --compatible-runtimes python3.7)
    LAYER_VERSION=$(jq '.Version' <<<"$result")
    LAYER_ARN=$(jq -r '.LayerArn' <<<"$result")

    echo "ahfdfafdadfas"
    echo "${LAYER_VERSION}"
    echo "${LAYER_ARN}"

    rm -rf python
    rm dependencies.zip
    cd ..
    rm -rf folder
}

publish_function_code() {
    echo "Deploying the code itself..."

    printenv >.env
    zip -r code.zip . -x \*.git\*
    aws lambda update-function-code --function-name "${INPUT_LAMBDA_FUNCTION_NAME}" --zip-file fileb://code.zip
}

update_function_layers() {
    echo "Using the layer in the function..."
    aws lambda update-function-configuration --function-name "${INPUT_LAMBDA_FUNCTION_NAME}" --layers "${LAYER_ARN}:${LAYER_VERSION}"
}

deploy_lambda_function() {
    publish_dependencies_as_layer
    publish_function_code
    update_function_layers
}

deploy_lambda_function
echo "Done."
