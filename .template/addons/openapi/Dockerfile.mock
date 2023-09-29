FROM stoplight/prism:latest

COPY /docs /usr/src/prism/packages/cli/docs/

EXPOSE 80

CMD ["mock", "-h", "0.0.0.0", "-p", "80", "docs/openapi/openapi.yml"]
