# ZSH workspace

Launch containers with a docker image, the secuence is

1. Get the image
2. If it has an started container go to step 5, else next step
3. Build if it is an file
4. Run a container with only the session
5. Start an bash console from the container


## Usage

It starts an container in Ubuntu with the current directory

```
$ workspace ubuntu
```

### Help
```
$ workspace image

	image   Dockerfile or the name imagen in DockerHub

	Options:
		-build     Aditional options for when it builds
		-run       Aditional options for when it runs
```


## Docker defaults options

* `--volume`: The pwd (current working directory), mount an directory in `/workspace/[folder its name]`
* `--workdir`: Starts in this work directory in `/workspace/[folder its name]`
* `--rm`: It only creates a container for the time do you use it
* `--interactive`: Connect with interactive
* `--tty` : Connect a console/terminal
