# Microsoft Azure vs. AWS

[Microsoft Azure and Amazon Web Services](https://azure.microsoft.com/en-us/campaigns/azure-vs-aws/mapping/)

### Region

##### 위치
* Azure : [https://azure.microsoft.com/en-us/regions/#overview](https://azure.microsoft.com/en-us/regions/#overview)
* AWS : [http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions)

##### 지역별 서비스
* Azure : [https://azure.microsoft.com/en-us/regions/#services](https://azure.microsoft.com/en-us/regions/#services)
* AWS : [https://aws.amazon.com/ko/about-aws/global-infrastructure/regional-product-services/](https://aws.amazon.com/ko/about-aws/global-infrastructure/regional-product-services/)

##### Availability Zone 
* Azure :
* AWS : [http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-regions-availability-zones](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-regions-availability-zones)

### Virtual Machine vs. EC2 instances

##### Instance size
* Azure : [https://azure.microsoft.com/ko-kr/documentation/articles/virtual-machines-windows-sizes/](https://azure.microsoft.com/ko-kr/documentation/articles/virtual-machines-windows-sizes/)
* AWS : [https://aws.amazon.com/ko/ec2/instance-types/](https://aws.amazon.com/ko/ec2/instance-types/)

##### Format
* Azure : [About disks and VHDs for Azure virtual machines](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-linux-about-disks-vhds/)
* AWS : [Amazon Machine Images (AMI)](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html)

##### Supported disk type
* Azure : [Azure Storage Scalability and Performance Targets](https://azure.microsoft.com/en-in/documentation/articles/storage-scalability-targets/#scalability-targets-for-virtual-machine-disks)
  * Stanard : HDD, 500 IOPS
  * Premium : SSD, 500/2300/5000 IOPS
* AWS : [Amazon EBS Volume Types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html?icmpid=docs_ec2_console)
  * Magnetic
  * Throughput optimized HDD (ST1)
  * Cold HDD (SC1)
  * General Purpose(GP2) : SSD, 3 IOPS/1GB
  * Provisioned IOPS(IO1) : SSD, upto 50 IOPS/1GB
  
##### Image
* Azure
  * Windows : 64 bit only, Windows Server 2008 R2 ~
  * Linux : [Linux on Azure-Endorsed Distributions](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-linux-endorsed-distros/) 
* AWS 
  * Virtualization
    * HVM : Hardware Virtualization
    * PV : Paravirtualization
    * https://aws.amazon.com/ko/amazon-linux-ami/instance-type-matrix/
  * Burst : [New Low Cost EC2 Instances with Burstable Performance](https://aws.amazon.com/ko/blogs/aws/low-cost-burstable-ec2-instances/)
  * Windows: **32**/64 bit(**Windows Server 2003 R2, Windows Server 2008**), Windows Server 2003 R2 ~
  * Linux
    * Amazon Linux : RHEL(Red Hat Enterprise Linux)를 기반, EC2에 최적화
    * [https://aws.amazon.com/marketplace/b/2649367011](https://aws.amazon.com/marketplace/b/2649367011)

##### Instance Purchasing Options
* Azure
* AWS : [http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-purchasing-options.html](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-purchasing-options.html)
    * On-Demand
    * Reserved
    * Scheduled
    * Spot
    * Dedicated **hosts**
    * Dedicated **instances**

### 기타

##### 요금 계산기
* Azure : [https://azure.microsoft.com/ko-kr/pricing/calculator/](https://azure.microsoft.com/ko-kr/pricing/calculator/)
* AWS : [http://calculator.s3.amazonaws.com/index.html](http://calculator.s3.amazonaws.com/index.html)

