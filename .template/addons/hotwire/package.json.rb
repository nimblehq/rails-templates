# frozen_string_literal: true

# Install dependencies
run 'yarn add --dev jest'
run 'yarn add --dev jest-environment-jsdom'
run 'yarn add --dev esbuild-jest'

# Jest config
run 'npm pkg set jest.testRegex[]="spec/javascript/.*_spec\\.js"'
run %(npm pkg set jest.transform='{"^.+\\\\.js?$": "esbuild-jest"}' -json)
run 'npm pkg set jest.testEnvironment="jsdom"'
run 'npm pkg set jest.roots[]="spec/javascript"'
run 'npm pkg set jest.moduleDirectories[]="node_modules"'
