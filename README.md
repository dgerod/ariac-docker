# ARIAC Finals

This repository contains the setup that will be used to automatically evaluate teams' submission for the Agile Robotics for Industrial Automation Competition (ARIAC) hosted by the National Institute of Standards and Technology (NIST).
For full details on the competition Finals, please see https://bitbucket.org/osrf/ariac/wiki/finals

## Overview

The setup that is created by the code in this repository is the setup that will be used for running the final competition.
There are two main components to the ARIAC competition setup: the ARIAC server, and the competitor's system.
For security and reproducibility, the ARIAC server and the competitor's system are run in separate isolated environments called containers.
Docker is used to create these containers.

## Getting the code

Clone this code repository locally:

```
git clone https://github.com/osrf/ariac-docker
cd ariac-docker
```

## Installing Docker

Please, follow [these instructions](https://docs.docker.com/engine/installation/linux/ubuntu/) and install `Docker CE`.

Continue to the [post-install instructions](https://docs.docker.com/engine/installation/linux/linux-postinstall/) and complete the "Manage Docker as a non-root user" section to avoid having to run the commands on this page using `sudo`.

## Preparing the workspace

Team configuration files must be put into a folder with the name of the team.

We have provided an example submission in this repository.
You should see that there is a directory called `example_team` that has the following configuration files in it:

```
build_team_system.bash  run_team_system.bash    team_config.yaml
```

Together these files constitute a submission.
The files are explained at https://bitbucket.org/osrf/ariac/wiki/finals

## Preparing the ARIAC system

To prepare the ARIAC competition system (but not run it), call:

```
./prepare_ariac_system.bash
```

This will build a Docker "image" of the competition server, ready to be launched as a container later.

## Preparing your team's system

To prepare your team's system (but not run it), call:

```
./prepare_team_system.bash example_team

# For your team you will run:
# ./prepare_team_system.bash <your_team_name>
```

This will build a Docker "image" of your team's system, ready to be launched with the ARIAC competition server.

## Running a single trial

To run a specific trial (in this case the trial called `example_trial1`), call:

```
./run_trial.bash example_team example_trial1

# For your team you will run:
# ./run_trial.bash <your_team_name> <trial_name>
```

This will instantiate Docker containers of the images that we prepared earlier: one for the ARIAC competition server, and one for your team's system.
The ARIAC environment will be started using the competition configuration file associated with the trial name (i.e. `comp_configs/example_trial1.yaml`), and the user configuration file associated with your team name (i.e. `example_team/team_config.yaml`).

Once the trial has finished (because your system completed the trial, because you made a call to the `/ariac/end_competition` service, or because time ran out), the logs from the trial will be available in the `logs` directory that has now been created locally.

## Reviewing the results of a trial

### Playing back the simulation

To play-back a specific trial's log file, you must have ARIAC installed on your machine, and then you can call:

```
roslaunch osrf_gear gear_playback.launch state_log_path:=`pwd`/logs/example_team/example_trial1/gazebo/state.log
```

### Reviewing the trial performance

Once the behavior observed when playing back the trial's log file looks correct, you should then check the completion score.
To do so, open the relevant `performance.log` file (e.g. `logs/example_team/example_trial1/performance.log`) and check the score output at the end of the file: it lists the scores for each order.

Here is an example game score for a single-order trial with 4 parts in the correct pose.

```
Score breakdown:
<game_score>
Total score: [27]
Total process time: [75.143]
Part travel time: [113.767]
<order_score order_0>
Total score: [12]
Time taken: [75.143]
Complete: [true]
<tray_score order_0_kit_0>
Total score: [12]
Complete: [true]
Submitted: [true]
Part presence score: [4]
All parts bonus: [4]
Part pose score: [4]
</tray_score>

</order_score>

</game_score>
```

## Running all trials

To run all trials listed in the `comp_configs` directory, call:

```
./run_all_trials.bash example_team

# For your team you will run:
# ./run_all_trials.bash <your_team_name>
```

This will run each of the trials sequentially automatically.
This is the invocation that will be used to test submissions for the Finals: your system will not be provided with any information about the trial number or the conditions of the trial.
If your system performs correctly with this invocation, regardless of the set of configuration files in the `comp_configs` directory, you're ready for the competition.

## Troubleshooting

If during your development you need to kill the ARIAC server/competitor containers, you can do so with:

```
./kill_ariac_containers.bash
```

This will kill and remove all ARIAC containers.