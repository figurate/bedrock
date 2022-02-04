# CI/CD Build

## Synopsis

The principles of Continuous Integration and Continuous Deployment are similar:

* Automate repetitive processes
* Avoid human/machine interaction whenever possible

The benefits of these principles are:

* Improved efficiency of processes that computers can perform faster than humans
* Reduced error rates and consistency

## Purpose

This blueprint is intended to provide support for CI/CD builds within a Cloud
tenancy. Builds that are contained within the account boundary are more
secure as they can be used to restrict permissions of external API users.

By allowing external users the ability to trigger builds only, tenancy
modifications are securely controlled and audited.
 