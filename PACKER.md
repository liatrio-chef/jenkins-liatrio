## Validate
`packer validate packer.json`

## Build
`berks install` or `berks update`
`berks vendor cookbooks`
`packer build packer.json`

*warning*: Changing the repo directory name to something other than `jenkins-liatrio`
will break the packer build process.

