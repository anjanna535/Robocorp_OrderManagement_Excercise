# README for the robot
Ordering robot will do the below part:

Orders robots from RobotSpareBin Industries Inc.
Saves the order HTML receipt as a PDF file.
Saves the screenshot of the ordered robot.
Embeds the screenshot of the robot to the PDF receipt.
Creates ZIP archive of the receipts and the images


## Development guide

Run the robot locally:
```
rcc run
```

Provide access credentials for Robocorp Cloud connectivity:
```
rcc configure credentials <your_credentials>
```

Upload to Robocorp Cloud:
```
rcc cloud push --workspace <workspace_id> --robot <robot_id>
```

### Suggested directory structure

The directory structure given by the template:
```
├── devdata
├── keywords
│   └── keywords.robot
├── libraries
│   └── Library.py
├── variables
│   └── variables.py
├── conda.yaml
├── robot.yaml
└── tasks.robot
```

where
* `devdata`: place for all data/material related to development, e.g. test data. Do not put any sensitive data here!
* `keywords`: Robot Framework keyword files.
* `libraries`: Python library code.
* `variables`: Define your robot variables in a centralized place. Do not put any sensitive data here!
* `conda.yaml`: Environment configuration file.
* `robot.yaml`: Robot configuration file.
* `tasks.robot`: Robot Framework task suite - high level process definition.

In addition to these you can create your own directories (e.g. `bin`, `tmp`). Add these directories to the `PATH` or `PYTHONPATH` section of `robot.yaml` if necessary.

Logs and artifacts are stored in `output` by default - see `robot.yaml` for configuring this.

See [Docs](https://robocorp.com/docs/development-howtos/variables-and-secrets/) for handling variables and secrets.


### Configuration

Give the task name and startup commands in `robot.yaml` with some additional configuration. See [Docs](https://robocorp.com/docs/setup/robot-structure#robot-configuration-file-robot-yaml) for more.


Put all the robot dependencies in `conda.yaml`. Robocorp App (and rcc) uses [Conda](https://docs.conda.io) for managing the execution environment. For development you can also install packages manually with `pip`.

### Additional documentation
See [Robocorp Docs](https://robocorp.com/docs/) for more documentation.
# Robocorp_OrderManagement_Excercise

