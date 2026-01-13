**Goal:** Create a security lab running optimally 4 virtual machines (2 Kali machines, 1 Windows Server, 1 Client) to simulate a real time attacker vs defender situation. One Kali machine will be used to penetration test, the other will be used to respond in real time. 

**Challenges:**
+ Cloud or Physical?
	+ We will be using a physical computer to run these 4 virtual machines
	+ Use VMware Workstation (costs) to run these virtual machines efficiently
+ How do you connect?
	+ We will use TailScale to run a vpn tunnel to allow devices on external networks to connect
	+ Eddie: I'll give you instructions on how to set this up, I just need to configure it
+ Resource limitations:
	+ Running on the mac mini probably wont work. It only has 4 cores, not enough to run 4 machines
	+ Instead, we'll use an old gaming laptop with plenty of cores and 32 GB of RAM. Just need to buy an NVME drive for it, which shouldn't be too expensive (500 GB)

**Windows Server Configuration:**
+ Use it as a AD-DC
+ Create an [[Organizational Unit (OU)]] for users (use the PowerShell script in AD lab to create ~100 users)
	+ Randomize 90% of the passwords for the users (base level privileges)
	+ Remaining 10%, give them assorted privileges and configured passwords, ranging from simple to strong according to their given privilege  
+ Create an Admin OU and add me and Eddie 
+ Install TailScale to it and configure

**Client Configuration:**
+ This will be a target for the pen-tester 
+ Choose any OS (Ubuntu or Windows?)
+ Add it to the domain when initially setting it up
+ Install TailScale to it to join it with the network

**Initial Tasks to be done:**
+ Create a GitHub Repo to store/share scripts
+ Get NVME drive for laptop
	+ Set it up with ubuntu
	+ Install VMware
	+ Configure TailScale (if needed)
	+ Set up VM's
+ Create PowerShell Script that randomizes passwords for users in AD and saves them in a txt file (Username, Password, Time of reset, preferably)

**Referral Links:**
+ [Active-Directory-Lab/GenerateNames.ps1 at main · whyelias/Active-Directory-Lab](https://github.com/whyelias/Active-Directory-Lab/blob/main/GenerateNames.ps1)
