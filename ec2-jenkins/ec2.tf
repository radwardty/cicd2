# AWS 리전
provider "aws" {
 region = "ap-northeast-1"
}


# VPC
variable "vpc_id" {
 default = "vpc-020c2063ea1c5566e"
}




# EC2
resource "aws_instance" "ec2" {
 ami                    = "ami-023ff3d4ab11b2525"    # AMI ID
 instance_type          = "t2.medium"                 # 인스턴스 유형
 key_name               = "saju-key-dev"             # 키 페어
 vpc_security_group_ids = ["sg-07d59683e81858ac3"] # 보안그룹 ID
 availability_zone      = "ap-northeast-1a"          # 가용영역
 user_data              = file("./userdata.sh")      # 사용자 데이타
 
 # 스토리지 정보
 root_block_device {
   volume_size = 30
   volume_type = "gp3"
 }
 # 태그 설정
 tags = {
   Name    = "cicd-jenkins-dev"
   Service = "cicd-dev"
 }
}

# 탄력적 IP 주소 할당
resource "aws_eip" "eip" {
  instance = aws_instance.ec2.id

  tags = {
    Name = "cicd-eip-dev"
    Service = "cicd-dev"
  }
}

# 탄력적 IP
output "eip_ip" {
    value = aws_eip.eip.public_ip
  
}
