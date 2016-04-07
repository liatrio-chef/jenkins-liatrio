jenkins-liatrio Cookbook
========================
This is a wrapper cookbook that installs jenkins to be used with archiva-liatrio, sonarqube-liatrio, tomcat-liatrio, and hygieia-liatrio in a pipeline.

Requirements
------------
Berkshelf

Vagrant 1.9.1

Usage
-----
#### jenkins-liatrio::default

`vagrant up`

or 

Just include `jenkins-liatrio` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[jenkins-liatrio]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Drew Holt <drew@liatrio.com>
