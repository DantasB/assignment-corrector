# assignment-corrector

## Objective

The objective of this action is to help the teacher of any language to correct your own activities using the github actions.

## How does it works

The idea is that the student will open a pull request to the repository of activities and them, given a set of tests, the action will run them on a container and compare the results between the two inputs.

## Inputs

### `programming-language`

**Required** The name of the programming language.

## Outputs

## `time`

The time we received your task

## Use Cases

```
uses: actions/assignment-corrector@v0.0.1-alpha
with:
    programming-language: 'python'
```
