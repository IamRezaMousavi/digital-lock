# Digital Lock Software

A software that run on digital lock hardware.

## Usage

### Getting Started

1. You need to install

    * [Arm Gnu Toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
    * [OpenOCD](https://openocd.org/pages/getting-openocd.html)
    * [Gnu Make](https://www.gnu.org/software/make/)

2. To fetch submodules, run:

    ```sh
    git submodule update --init --recursive
    ```

3. To Build the project, you must run:

    ```sh
    make
    ```

4. To Upload code to hardware, you must to connect the programmer to laptop and run:

    ```sh
    make flush
    ```

### Format The Code

You need to have `clang-format` in PATH
Then run:

```sh
make format
```

## Screenshot

Normal Mode | Disable Mode | Add User Mode
--- | --- | ---
![normal-mode](./Screenshots/Picture1.jpg) | ![disable-mode](./Screenshots/Picture2.jpg) | ![add-user-mode](./Screenshots/Picture3.jpg)
