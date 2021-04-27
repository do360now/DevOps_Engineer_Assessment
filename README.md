# Devops Engineer Assessment
<img src="https://github.com/do360now/DevOps_Engineer_Assessment/blob/main/wizard.jpg" alt="magic" width="150">
DevOps Engineer Assessment project Jenkins, Docker, Terraform, Kubernetes

# Jump to content

- [Installation steps](#Installation-steps)
- [Demo](#Demo)
- [Caveats](#Caveats)


# What is this about?

> Abracadabra or magic besides being an incantation used as a magic word and belived to have healing powers, is a DevOps challenge solution consisting of a wonderful set of one-click-install artifacts for having a full-fledged Win10-based CICD DevOps environment suited for industry adoption.

# Installation steps

The goal of this challenge consists of two parts.
1. ```setup-env.ps1```: A script that will install all the tools needed for this challenge: Chocolatey, Docker, Terraform, Kubernetes, Minikube, Git and WSL
2. ```setup-project.ps1```: A script that will create a cluster using minikube, a kubernetes deployment using terraform, a Jenkins with a predefined pipeline container and agent container. 

### How it works
1. The ```setup-env.ps1``` script will first check if Chocolatey is installed, if it´s not installed, it will install it and continue the execution of the script. Will check if the rest of the tools are installed and, if not, will install it.
2. The ```setup-project.ps1``` will first deploy a cluster using minikube. It will also start terraform and start creating the jenkins CICD server using kubernetes, once the deployment is completed, it will launch a new browser window with preconfigured jenkins server that includes a pipeline that deploys a project from github `(https://github.com/do360now/JenkinsDocker).`

    
## System requirements

- Local or Virtual Machine with at least `8GB of RAM`, `20GB of free disk space` and `Windows 10 Pro/Enterprise (16299+) or Windows 10 Home (18362.1040+)`

- `Powershell version => 5` console with `admin rights`

## Step 1
- Open the Powershell console as admin <br>
`WIN key + X` and select `Windows Powershell (Admin)`

- Copy and `conjure up` the following spell-ish:


```ps
mkdir magic; wget (Invoke-RestMethod -uri  https://github.com/do360now/DevOps_Engineer_Assessment/releases/tag/latest | select -expand tarball_url) -o t.tar.gz | tar -xf t.tar.gz -C magic --strip-components 1; cd magic; .\setup-env.ps1
```

This will install on your system all required packages and **restart your computer** afterwards.


## Step 2

- Once the environment is setup, make sure you are in the `/magic/DevOps_Engineer_Assessment` folder and execute `setup-project.ps1` script

```sh
cd .\magic\
.\setup-project.ps1
```

- The script will do the following:
- Start minikube cluster
- Apply Terraform Plan using Kubernetes as a provider to configure the new cluster
- Launch a new browser window with the new jenkins server and pipeline automagically configured.

> The following technologies were used:
  · Jenkins - create CICD pipeline
  · Docker along with a Dockerfile to create a custom images, for both jenkins master and agent
  · Terraform - Configure the entire setup
  · Kubernetes - Ochastrate the deployment of pods

- You can now start your developing and run a `Build` for the `Console App pipeline`. 

- You can check the current Jenkins job running.

- Upon successful completion you can review the details of the build.

# Cleanup
- From your `magic` directory run `cleanup-project.ps1`

- <h1> <strike>Happy</strike> Wizardly development </h1>

# Caveats

Because of all the `WIP` I currently have going,  I could not figure out in time how to get the jenkins kubernetes plugin working correctly. The build agent is orchestrated by Docker, but I will continue to look at this issue and try to make it work. 