<a href="https://github.com/Athexblackhat/BlueJack"><img src="/images/bluejack_logo.jpg" alt="0" border="0" /></a> 


# BlueJack - Bluetooth HID Attack Tool

[![Version](https://img.shields.io/badge/version-2.0-blue.svg)](https://github.com/yourusername/bluejack)
[![Python](https://img.shields.io/badge/python-3.6%2B-green.svg)](https://www.python.org/)
[![License](https://img.shields.io/badge/license-MIT-red.svg)](https://opensource.org/licenses/MIT)

## ⚠️ DISCLAIMER

**BlueJack is a penetration testing tool designed for authorized security assessments only.**

Unauthorized use of this tool against devices you do not own or have explicit permission to test is **illegal**. The authors assume no liability for misuse or damage caused by this software. Always obtain proper authorization before conducting security testing.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [How It Works](#how-it-works)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Payload Examples](#payload-examples)
- [Supported Commands](#supported-commands)
- [Troubleshooting](#troubleshooting)
- [Legal Considerations](#legal-considerations)
- [Contributing](#contributing)
- [License](#license)

---

## 🔍 Overview

**BlueJack** is a powerful Bluetooth HID (Human Interface Device) attack tool that emulates a Bluetooth keyboard to execute DuckyScript payloads on target devices. By impersonating a legitimate HID keyboard, BlueJack can inject keystrokes, execute commands, and automate attacks on vulnerable Bluetooth devices.

Named after the concept of "jack" as in hijacking, BlueJack demonstrates the risks associated with Bluetooth auto-pairing and insecure HID implementations.

---

## ✨ Features

- **Bluetooth HID Emulation**: Appears as a standard Bluetooth keyboard
- **DuckyScript Support**: Execute custom payloads written in DuckyScript
- **Auto-Pairing**: Uses "NoInputNoOutput" pairing agent for seamless connection
- **Connection Recovery**: Automatically reconnects if connection drops
- **Resume Capability**: Continues payload execution from last successful keystroke
- **Device Scanning**: Discover nearby Bluetooth devices
- **Known Devices Storage**: Persists discovered devices for future use
- **Color-Coded Logging**: Easy-to-read output with ANSI colors
- **Cross-Platform Payloads**: Works on Windows, macOS, Linux, and Android
- **Modifier Key Support**: GUI/Windows, CTRL, ALT, SHIFT combinations

---

## 🛠 How It Works
```
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│ BlueJack │ │ BlueZ Stack │ │ Target Device │
│ (Attacker) │◄───────►│ (Linux) │◄───────►│ (Victim) │
└─────────────────┘ └─────────────────┘ └─────────────────┘
│ │ │
│ 1. Register HID Profile │ │
├──────────────────────────►│ │
│ │ 2. L2CAP Connection │
│ ├──────────────────────────►│
│ │ (PSM 17: HID Control) │
│ │ (PSM 19: HID Interrupt) │
│ │ │
│ 3. Pairing Request │ │
├──────────────────────────►│ │
│ │ 4. Auto-Pair (NoInput) │
│ ├──────────────────────────►│
│ │ │
│ 5. Send HID Reports │ │
├──────────────────────────►│──────────────────────────►│
│ (Keystroke Injection) │ │
│ │ │
```

**Technical Details:**

1. **HID Profile Registration**: BlueJack registers a virtual keyboard profile with BlueZ using D-Bus
2. **L2CAP Channels**: Establishes connections on PSM 17 (HID Control) and PSM 19 (HID Interrupt)
3. **Auto-Pairing**: Uses "NoInputNoOutput" capability to pair without user interaction
4. **Keystroke Injection**: Sends HID reports formatted as keyboard input
5. **Payload Execution**: Parses DuckyScript and converts each command to HID usage codes

---

## 📦 Requirements

### System Requirements
- **Operating System**: Linux (Ubuntu/Debian/Kali recommended)
- **Python**: 3.6 or higher
- **Bluetooth Adapter**: Built-in or USB Bluetooth dongle
- **Root/Sudo Access**: Required for Bluetooth operations


🚀 Installation


git clone https://github.com/Athexblackhat/BlueJack.git
cd BlueJack


# Install system dependencies

sudo apt-get update
sudo apt-get install -y python3-pip python3-dbus python3-gi bluez



pip3 install pydbus pybluez dbus-python

 Configure Bluetooth
bash
# Ensure Bluetooth service is running
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Check adapter status
hciconfig
4. Create Directory Structure
bash
mkdir -p payloads
5. Verify Installation
bash
python3 BlueJack.py --help
💻 Usage
Basic Usage
bash
# Run with default adapter (hci0)
sudo python3 BlueJack.py

# Specify a different Bluetooth adapter
sudo python3 BlueJack.py --adapter hci1



Select Target: Either enter MAC address or scan for devices

Choose Payload: Select from available .txt files in payloads/ folder

Execute: BlueJack connects and begins keystroke injection

Monitor: Watch the console for progress and status updates

Example Session
```
$ sudo python3 BlueJack.py


    BBBBBBBBBBBBBBBBB   LLLLLLLLLLL         UUUUUUUU     UUUUUUUUEEEEEEEEEEEEEEEEEEEEEE
    B::::::::::::::::B  L:::::::::L         U::::::U     U::::::UE::::::::::::::::::::E
    B::::::BBBBBB:::::B L:::::::::L         U::::::U     U::::::UE::::::::::::::::::::E
    BB:::::B     B:::::BLL:::::::LL         UU:::::U     U:::::UUE::::::EEEEEEEEE::::
      B::::B     B:::::B  L:::::L            U:::::U     U:::::U E:::::E       EEEEEE
      B::::B     B:::::B  L:::::L            U:::::D     D:::::U E:::::E              
      B::::BBBBBB:::::B   L:::::L            U:::::D     D:::::U E::::::EEEEEEEEEE    
      B:::::::::::::BB    L:::::L            U:::::D     D:::::U E:::::::::::::::E    
      B::::BBBBBB:::::B   L:::::L            U:::::D     D:::::U E:::::::::::::::E    
      B::::B     B:::::B  L:::::L            U:::::D     D:::::U E::::::EEEEEEEEEE    
      B::::B     B:::::B  L:::::L            U:::::D     D:::::U E:::::E              
      B::::B     B:::::B  L:::::L        LLLLU::::::U   U::::::U E:::::E         EEEEEE
    BB:::::BBBBBB::::::BLL:::::::LLLLLLLLL:::U:::::::UUU:::::::UEE::::::::EEEEEEEE::::E
    B:::::::::::::::::B L::::::::::::::::::::LU:::::::::::::::UU E::::::::::::::::::::E
    B::::::::::::::::B  L::::::::::::::::::::L U:::::::::::::U   E::::::::::::::::::::E
    BBBBBBBBBBBBBBBBB   LLLLLLLLLLLLLLLLLLLLLLL  UUUUUUUUUUU     EEEEEEEEEEEEEEEEEEEEEE
                                                                              
                         Bluetooth HID Attack Tool                            
                               Version 2.0                                    


======================================================================
                      BlueJack - Bluetooth HID Attack Tool                      
======================================================================
Remember, you can still attack devices without visibility...
If you have their MAC address
======================================================================

What is the target address? Leave blank and we will scan for you: 

Attempting to scan now...

Found 3 nearby device(s):
1: Device Name: iPhone 14, Address: AA:BB:CC:DD:EE:FF
2: Device Name: Samsung Galaxy S22, Address: 11:22:33:44:55:66
3: Device Name: Dell XPS Laptop, Address: 77:88:99:AA:BB:CC

Select a device by number: 3

Available payloads:
1: windows_reverse_shell.txt
2: windows_info_grabber.txt
3: linux_quick_test.txt

Enter the number of the payload you want to load: 3
Selected payload: /home/user/bluejack/payloads/linux_quick_test.txt

[2024-01-15 10:30:15] - INFO - executing 'sudo service bluetooth restart'
[2024-01-15 10:30:16] - INFO - connecting to 77:88:99:AA:BB:CC on port 19
[2024-01-15 10:30:17] - INFO - Processing GUI SPACE
[2024-01-15 10:30:18] - INFO - Processing STRING Terminal
[2024-01-15 10:30:18] - NOTICE - Attempting to send letter: T
[2024-01-15 10:30:18] - NOTICE - Attempting to send letter: e
...
```




## 🔧 Troubleshooting
Common Issues and Solutions
1. Permission Denied

Error: Unable to find adapter 'hci0'
Solution: Run with sudo privileges


sudo python3 BlueJack.py
2. Bluetooth Adapter Not Found

Error: Adapter not found
Solution: Check adapter status


hciconfig
sudo hciconfig hci0 up
3. Connection Failed

4. Error: Connection failure on port 19
Solution:

Ensure target device is discoverable

Check Bluetooth range

Restart Bluetooth service



5. Error: org.freedesktop.DBus.Error.ServiceUnknown

Solution: Ensure BlueZ is running


sudo service bluetooth start
sudo systemctl restart dbus
6. Pairing Fails

Error: Failed to initialize pairing agent
Solution:

Check if target accepts "NoInputNoOutput" pairing

Some devices require confirmation

Try scanning again

### ⚖️ Legal Considerations
Authorized Use Only
BlueJack is designed for:

Penetration Testing: Authorized security assessments

Security Research: Understanding Bluetooth vulnerabilities

Education: Learning about HID attacks and Bluetooth security

Compliance Testing: Verifying security controls

Unauthorized Use Is Illegal
Using BlueJack on devices without explicit permission may violate:

Computer Fraud and Abuse Act (CFAA) - US

Computer Misuse Act - UK

Similar laws in other jurisdictions

Privacy regulations (GDPR, CCPA)

Best Practices
Get Written Authorization: Always obtain written permission before testing

Use in Isolated Environments: Test in lab environments when possible

Document Everything: Keep logs of authorized testing activities

Responsible Disclosure: Report vulnerabilities to affected vendors


# 📄 License
This project is licensed under the MIT License - see below:

MIT License

Copyright (c) 2024 BlueJack Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

**Developer**
          *ATHEX BLACK HAT*