provider "aws" {
  region     = "ap-south-1"
}
#create IAM USER

resource "aws_iam_user" "my_iam_user1" {
  name = "test_user1"
}
resource "aws_iam_user" "my_iam_user2" {
  name = "test_user2"
}
resource "aws_iam_user" "my_iam_user3" {
  name = "test_user3"
}


# Creating IAM GROUP
resource "aws_iam_group" "my_user_group" {
  name = "devOps_group"
}

# ATTACH POLICY TO USER GROUP
resource "aws_iam_group_policy_attachment" "my_iam_user_group_policy_attachment" {
  group      = aws_iam_group.my_user_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

#ADD USER TO GROUP
resource "aws_iam_user_group_membership" "my_iam_user_group_membership1" {
  user   = aws_iam_user.my_iam_user1.name
  groups = [aws_iam_group.my_user_group.name]
}
resource "aws_iam_user_group_membership" "my_iam_user_group_membership2" {
  user   = aws_iam_user.my_iam_user2.name
  groups = [aws_iam_group.my_user_group.name]
}
resource "aws_iam_user_group_membership" "my_iam_user_group_membership3" {
  user   = aws_iam_user.my_iam_user3.name
  groups = [aws_iam_group.my_user_group.name]
}

