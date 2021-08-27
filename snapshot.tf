
#  *****  Create a snapshot of volume  *****

resource "aws_ebs_snapshot" "snapshot" {
  depends_on = [null_resource.skills]
  volume_id = aws_ebs_volume.volume_task-5.id

  tags = {
    Name = "Snapshot of vol attached with ec2"
  }
  
}
