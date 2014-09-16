# Introduction

A safe implementation of CSON that doesn't require the `coffee-script` NPM package.

Currently, it's just a wrapper around `cson-safe`, so that we don't have to go back and update all the projects using `c50n`.

However, the other reason we're doing that is because we want to be able to `stringify` to CSON, not just JSON (even though CSON is a superset of JSON, so JSON is valid CSON).
