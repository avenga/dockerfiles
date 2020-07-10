{{ $domains := (datasource "environment" "domains.yml") | yamlArray -}}
{{ $global := (datasource "globals" "global.json") | json -}}
version: "v1"
project: "{{.Env.TEMPLATE_ENVIRONMENT}}"
services:
  frontend:
    website:
      image: "{{.Env.WEBSITE_IMAGE}}:{{.Env.WEBSITE_VERSION}}"
      instances: {{.Env.WEBSITE_INSTANCES}}
      mem: {{.Env.WEBSITE_MEM}}
      ssl: true
      port: {{.Env.WEBSITE_PORT}}
      env:
        - WEBSITE_PORT: "{{.Env.WEBSITE_PORT}}"
        - HAPROXY_0_REDIRECT_TO_HTTPS : "true"
        - AWESOME: "{{$global.awesome}}"
      domain: {{range $domains -}}{{ . }} {{end}}
