# Generic Helm Template with Sops

## Requirements
- helm3
- helm-secrets
- sops
- a KMS Service (aws kms, google kms, vault, something sops supports)

## Usage

### Initial Implementation
- Copy the `artifact-service` folder under the target repository
- Rename the `artifact-service` to the name of the target repository
- Search and replace all `artifact-service` strings with the name of the target repository
- Change the values containing XXXX strings in the template
- Add Environment variables
- Add Secrets
- Integrate sops
- Encrypt `secrets.yaml`s
- Happy Helming


### In CI/CD Pipelines
Whatever tooling you use, the resulting helm command should look like the following, assuming you are in the helm chart directory:

`helm secrets upgrade -i . -f values.yaml -f helm_vars/$ENVIRONMENT/values.yaml -f helm_vars/$ENVIRONMENT/secrets.yaml --set image.tag=$BUILD_VERSION`

so it would execute like

`helm secrets upgrade -i . -f values.yaml -f helm_vars/alpha/values.yaml -f helm_vars/alpha/secrets.yaml --set image.tag=117`

for other requirements feel free to add the following flags
- `--atomic`
- `--timeout 600`