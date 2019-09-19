# 7val/sloppy-rollout

![pulls](https://img.shields.io/docker/pulls/7val/sloppy-rollout.svg)
![size](https://images.microbadger.com/badges/image/7val/sloppy-rollout.svg)
[![commit](https://images.microbadger.com/badges/commit/7val/sloppy-rollout.svg)](https://microbadger.com/images/7val/sloppy-rollout)

This image runs a deployment to Sloppy with the help of a provided configuration
file. This can be either a "plain" JSON/YML file or a template.

It just adds the deployment of plain files to `7val/sloppy-deployment`. But
since the interface had to change in a way which is not backward-compatible this
new image was created.

## Modes

The mode decides if a template is used as as source to create the Sloppy YAML
configuration file or a configuration file in JSON or YAML is provided as-is.

Both modes require the projects name to be given in the template or file.

### `template`

It generates a `sloppy.yml` from a [Gomplate](https://gomplate.ca/) template
file. The name can be overriden with the variable SLOPPY_TEMPLATE_FILE, but the
format must be YAML. The `sloppy.yml` gets generated via environment variables.
See [test/deployment](test/deployment) for an example.

### `file`

In this mode a complete Sloppy configuration file in YAML or JSON is provided
and no templating is done.

## Add configuration file

To add the Sloppy configuration file or template you have to built a new image
with code which adds the above file.
E.g.:
```
FROM 7val/sloppy-rollout:latest
COPY sloppy.json ./
```
The name of the added file is the value of `SLOPPY_CONFIG_FILE` (s. below).

## Variables

The image takes the following environment variables to configure it's behaviour.

* *DRY_RUN*: Just print the contents of the Sloppy configuration file and do
  not run a deployment. Optional.
* *SLOPPY_SAVE_OUTPUT_DIR*: Takes a directory as value. If this variable is set,
  the deployed `sloppy.yml` is copied to SLOPPY_SAVE_OUTPUT_DIR. This should be
  a volume to get the file out of the container. The volume **must** not be
  mounted under `/work` which is the WORKDIR inside the container.
  This also works when DRY_RUN is set. Optional.
* *SLOPPY_MODE*: Mode in which the configuration file should be handled. Values
  are "file" or "template" when the file is a template. Must be set.
* *SLOPPY_CONFIG_FILE*: Name of the Sloppy configuration file to use. Must be
  set.
* *SLOPPY_APITOKEN*: API token to access the chosen project. Must be set.
* *TEMPLATE_ENVIRONMENT*: If the `template` mode is used, this variable must be
  set to the name of the environment from which the files should be used.
* *SLOPPY_ROLLOUT_TRACE*: Run the entrypoint in debug. Sets `-x` in the shell
  script. Optional.

## Test

Run from the project's root the command `make build test
-e IMAGES=sloppy-rollout`. The tests reside under [test/](test/).
