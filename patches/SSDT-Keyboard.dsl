DefinitionBlock("", "SSDT", 2, "OCLT", "BrightFN", 0)
{
    External(_SB.PCI0.LPCB.KBD, DeviceObj)
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.PCI0.LPCB.EC.XQ6A, MethodObj)
    External(_SB.PCI0.LPCB.EC.XQ15, MethodObj)
    External(_SB.PCI0.LPCB.EC.XQ14, MethodObj)
    External(_SB.PCI0.LPCB.EC.XQ16, MethodObj)
    External(_SB.PCI0.LPCB.EC.XQ64, MethodObj)
    External(_SB.PCI0.LPCB.EC.XQ66, MethodObj)
    External(_SB.PCI0.LPCB.EC.XQ60, MethodObj)
    External(_SB.PCI0.LPCB.EC.XQ61, MethodObj)
    External(_SB.PCI0.LPCB.EC.XQ62, MethodObj)
    
    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q6A, 0, NotSerialized) // F4 - Microphone Mute
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.KBD, 0x033E)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ6A()
            }
        }
        
        Method (_Q15, 0, NotSerialized) // F5 - Brightness Down
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.KBD, 0x0405)
                Notify(\_SB.PCI0.LPCB.KBD, 0x20)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ15()
            }
        }

        Method (_Q14, 0, NotSerialized) // F6 - Brightness Up
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.KBD, 0x0406)
                Notify(\_SB.PCI0.LPCB.KBD, 0x10)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ14()
            }
        }
        
        Method (_Q16, 0, NotSerialized) // F7 - Dual Display
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.KBD, 0x046E)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ16()
            }
        }
        
        Method (_Q64, 0, NotSerialized) // F8 - Network
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.KBD, 0x0369)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ64()
            }
        }
        
        Method (_Q66, 0, NotSerialized) // F9 - Settings
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.KBD, 0x036A)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ66()
            }
        }
        
        Method (_Q60, 0, NotSerialized) // F10 - Bluetooh
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.KBD, 0x036B)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ60()
            }
        }
        
        Method (_Q61, 0, NotSerialized) // F11 - Keyboard
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.KBD, 0x0368)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ61()
            }
        }
        
        Method (_Q62, 0, NotSerialized) // F12 - Star
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.KBD, 0x036C)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ62()
            }
        }
    }
        
    Scope (_SB.PCI0.LPCB.KBD)
    {
        // Select specific configuration in VoodooPS2Trackpad.kext
        Method(_DSM, 4)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                "RM,oem-id", "LENOVO",
                "RM,oem-table-id", "Thinkpad_Clickpad",
            })
        }
        // Overrides (the example data here is default in the Info.plist)
        Name(RMCF, Package()
        {
            "Synaptics TouchPad", Package()
            {
                "BogusDeltaThreshX", 800,
                "BogusDeltaThreshY", 800,
                "Clicking", ">y",
                "DragLockTempMask", 0x40004,
                "DynamicEWMode", ">n",
                "FakeMiddleButton", ">n",
                "HWResetOnStart", ">y",
                //"ForcePassThrough", ">y",
                //"SkipPassThrough", ">y",
                "PalmNoAction When Typing", ">y",
                "ScrollResolution", 800,
                "SmoothInput", ">y",
                "UnsmoothInput", ">y",
                "Thinkpad", ">y",
                "EdgeBottom", 0,
                "FingerZ", 30,
                "MaxTapTime", 100000000,
                "MouseMultiplierX", 2,
                "MouseMultiplierY", 2,
                "MouseScrollMultiplierX", 2,
                "MouseScrollMultiplierY", 2,
                //"TrackpointScrollYMultiplier", 1, //Change this value to 0xFFFF in order to inverse the vertical scroll direction of the Trackpoint when holding the middle mouse button.
                //"TrackpointScrollXMultiplier", 1, //Change this value to 0xFFFF in order to inverse the horizontal scroll direction of the Trackpoint when holding the middle mouse button.
            },
            "Keyboard", Package()
            {
                "Custom PS2 Map", Package()
                {
                    Package() { },
                    "e037=64", // PrtSc=F13
                },
            },
        })
    }
}
//EOF