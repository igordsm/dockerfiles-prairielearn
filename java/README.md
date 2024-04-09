PrairieLearn recommends workspaces to disable network access to prevent cheating and "unexpected" activities in general. Maven keeps all dependencies download in the `$HOME/m2` folder. 

In order for this container to work offline the following steps must be taken:

1. open a project that has all dependencies needed for the workspace
2. build it once with maven
3. merge your `$HOME/.m2` with the one in this repository.
4. rebuild the docker image

