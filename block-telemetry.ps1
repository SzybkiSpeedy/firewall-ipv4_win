#   Description:
# This script blocks telemetry related domains via the hosts file and related
# IPs via Windows Firewall.
#
# Please note that adding these domains may break certain software like iTunes
# or Skype. As this issue is location dependent for some domains, they are not
# commented by default. The domains known to cause issues marked accordingly.
# Please see the related issue:
# <https://github.com/W4RH4WK/Debloat-Windows-10/issues/79>

# Entries related to Akamai have been reported to cause issues with Widevine
# DRM.

Write-Output "" | Out-File -Encoding ASCII -Append $hosts_file
foreach ($domain in $domains) {
    if (-Not (Select-String -Path $hosts_file -Pattern $domain)) {
        Write-Output "0.0.0.0 $domain" | Out-File -Encoding ASCII -Append $hosts_file
    }
}

Write-Output "Adding telemetry ips to firewall"
$ips = @(
    # Windows telemetry
    "134.170.30.202"
    "137.116.81.24"
    "157.56.106.189"
    "184.86.53.99"
    "2.22.61.43"
    "2.22.61.66"
    "204.79.197.200"
    "23.218.212.69"
    "65.39.117.230"
    "65.52.108.33"   # Causes problems with Microsoft Store
    "65.55.108.23"
    "64.4.54.254"
	"20.65.128.0/17"
	"31.14.32.0/28"
	"31.14.32.0/24"
	"193.105.134.0/24"
	"146.88.240.0/23"
	"146.88.240.0/20"
	"80.82.70.0/24"
	"80.82.64.0/21"
	"80.82.72.0/24"
	"80.82.64.0/22"
	"80.82.68.0/23"
	"18.221.128.0/19"
	"18.220.0.0/15"
	"18.216.0.0/13"
	"18.224.0.0/14"
	"203.220.207.0/24"
	"203.220.206.0/23"
	"203.220.161.0/24"
	"203.220.162.0/23"
	"203.220.164.0/22"
	"203.220.168.0/21"
	"203.220.176.0/20"
	"203.220.192.0/20"
	"203.220.208.0/23"
	"188.114.96.0/23"
	"188.114.96.0/22"
	"78.128.113.0/24"
	"78.128.112.0/23"
	"65.49.1.0/24"
	"65.49.0.0/22"
	"65.49.4.0/24"
	"142.250.128.0/19"
	"142.250.147.64/27"
	"142.250.145.0/24"
	"142.250.146.0/23"
	"142.250.148.0/23"
	"142.250.150.0/24"
	"142.250.147.8/29"
	"142.250.147.16/28"
	"142.250.147.32/27"
	"142.250.147.64/27"
	"142.250.147.96/28"
	"142.250.147.112/29"
	"142.250.147.120/30"
	"199.45.154.0/24"
	"199.45.154.0/23"
	"199.45.154.4/30"
	"199.45.154.4/30"
	"199.45.154.16/28"
	"199.45.154.32/27"
	"199.45.154.64/26"
	"199.45.154.128/25"
	"199.45.155.0/24"
	"45.135.95.0/24"
	"45.135.92.0/22"
	"45.135.92.0/22"
	"136.228.141.0/24"
	"136.228.140.0/23"
	"136.228.131.0/24"
	"136.228.132.0/22"
	"136.228.136.0/21"
	"136.228.128.0/20"
	"184.105.139.64/26"
	"184.105.137.0/24"
	"184.105.138.0/23"
	"184.105.140.0/25"
	"184.105.140.128/26"
	"184.105.140.192/27"
	"184.105.140.224/28"
	"184.105.137.0/24"
	"184.105.138.0/23"
	"64.62.197.0/24"
	"64.62.199.0/25"
	"64.62.199.128/26"
	"64.62.199.192/27"
	"64.62.199.224/29"
	"64.62.199.232/30"
	"64.62.197.0/24"
	"64.62.198.0/24"
	"23.94.186.192/27"
	"23.94.182.0/23"
	"23.94.184.0/21"
	"23.94.156.0/22"
	"23.94.160.0/19"
	"57.129.64.0/25"
	"57.129.64.0/20"
	"57.129.0.0/18"
	"57.129.64.0/19"
	"57.129.96.0/23"
	"57.129.0.0/18"
	"57.129.64.0/19"
	"57.129.96.0/23"
	"45.142.193.0/24"
	"91.148.190.0/24"
	"91.148.190.0/23"
	"135.237.0.0/17"
	"135.237.0.0/16"
	"94.159.96.0/21"
	"94.159.96.0/20"
	
    # NVIDIA telemetry
    "8.36.80.197"
    "8.36.80.224"
    "8.36.80.252"
    "8.36.113.118"
    "8.36.113.141"
    "8.36.80.230"
    "8.36.80.231"
    "8.36.113.126"
    "8.36.80.195"
    "8.36.80.217"
    "8.36.80.237"
    "8.36.80.246"
    "8.36.113.116"
    "8.36.113.139"
    "8.36.80.244"
    "216.228.121.209"
)
Remove-NetFirewallRule -DisplayName "DROP IPs" -ErrorAction SilentlyContinue
New-NetFirewallRule -DisplayName "DROP IPs" -Direction Outbound `
    -Action Block -RemoteAddress ([string[]]$ips)

# Block scheduled telemetry tasks
# See reference: https://answers.microsoft.com/en-us/windows/forum/windows_10-performance/permanently-disabling-windows-compatibility/6bf71583-81b0-4a74-ae2e-8fd73305aad1

