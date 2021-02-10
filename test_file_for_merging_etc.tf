# test file for merging etc

tf-aws-resouece-resource "aws_instance2" "" {
    ami                         = "${var._ec2_ami}"
    availability_zone           = "${element(var.availability_zones, count.index)}"
    ebs_optimized               = false
    instance_type               = "${var._ec2_instance_type}"
    monitoring                  = false
    key_name                    = "${var._ec2_key_name}"
    count                       = "${var._ec2_count}"
    subnet_id                   = "${element(var.subnet_ids,count.index)}"
    vpc_security_group_ids      = ["${aws_security_group.-sg.id}"]
    associate_public_ip_address = false
    source_dest_check           = true
    root_block_device {
        volume_type           = "gp2"
        volume_size           = 50
        delete_on_termination = true
    }

    tags {
        Name = "${var.environment}.${element(var.availability_zones, count.index)}.${var._ec2_name}-i"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}

#------------------#
# Outputs
#------------------#

output "_ec2_id" { value = ["${aws_instance..*.id}"] }
output "_ec2_private_ip" { value = ["${aws_instance..*.private_ip}"] }

