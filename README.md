# Toy robot simulator

## Instalation

Prerequisites:
 - Ruby 2.6.x

No dependencies are required to run the robot simulator.
To run the program:

```bash
  bin/robot
```

The program accepts the following command-line arguments:

 - `-s SIZE`, `--size=SIZE` - Board size. Defaults to 5
 - `-v`, `--version` - Show version and exit
 - `-d`, `--debug` - Print debug messages
 - `-h`, `--help` - Prints help message

## Development

Prerequisites:
 - Ruby 2.6.5
 - Bundler

No dependencies are required to run the robot simulator. However, some are required for development. Install the development dependencies with Bundler

```bash
  bundle install
```

To run tests:
```bash
  bundle exec rspec
```
