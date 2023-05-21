# Notes for utilizing the .Net Framwork inside of PowerShell

## .NET API Reference

[Here is the link to the .NET API Reference](https://docs.microsoft.com/en-us/dotnet/api/?view=netcore-3.1)

[Here is the link to the .NET API browser PowerShell 7 SDK](https://docs.microsoft.com/en-us/dotnet/api/?view=powershellsdk-7.0.0)

## Commands to utilize .NET

Step 1. Test if you are on Windows
`Test-Path c:\`

Step 2. If on Windows test if PowerShell Core is installed (Optional)
`Test-path "C:\Program Files\PowerShell"`

Step 3. Move into PowerShell Core Directory, if on MAC or Linux
`cd $PSHOME`

Step 4. Load the Associated dll into your session, if on MAC or Linux (Example uses the "System.Environment" namespace)
`Add-Type -AssemblyName System.Runtime.Extentions.dll`

The `Add-Type` cmdlet lets you define a Microsoft .NET Core class in your PowerShell session. You can then instantiate objects, by using the `New-Object` cmdlet, and use the objects just as you would use any .NET Core object. If you add an `Add-Type` command to your PowerShell profile, the class is available in all PowerShell sessions.

Depricated way of adding in the .Net Namespace  
`[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")`

Replacement way of adding in the .NET Namespace

Step 5. At this point you can use the .NET Class directly  
[NameSpace]::Property/Method  
`[System.Environment]::GetLogicalDrives()`  

### Issues 

Ran into and issue tring to save [System.Enviroment] as an object.  
`$SystemEnvironment = New-Object `

  ```Error
  New-Object: A constructor was not found. Cannot find an appropriate constructor for type System.Environment.
  ```
I was successful at `$system Environment = [System.Environment]`

### Example of Memory Manager Class

1. load System.Runtime.dll
`Add-Type -AssemblyName System.Runtime.dll -PassThru`

2. Verify I can accsess all of the MemoryManager Properties and Methods.  I was not able to access it at all.  I did notice that it is a \<T\> class.

3. I was able to System.Buffers.MemoryHandle and all of its Properties and methods.  It did not or was not part of the \<T\> class

4. I was also able to load [System.Buffers.IPinnable], which is a 



## API Reference to dump memory of a process

BOOL MiniDumpWriteDump(
  HANDLE                            hProcess,
  DWORD                             ProcessId,
  HANDLE                            hFile,
  MINIDUMP_TYPE                     DumpType,
  PMINIDUMP_EXCEPTION_INFORMATION   ExceptionParam,
  PMINIDUMP_USER_STREAM_INFORMATION UserStreamParam,
  PMINIDUMP_CALLBACK_INFORMATION    CallbackParam
);