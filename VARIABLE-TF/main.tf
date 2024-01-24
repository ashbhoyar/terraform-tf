resource "aws_iam_user" "user1" {
    name = var.user_name
    path = var.user_path
    tags = var.user_tags

}

resource "aws_iam_user" "user2" {
    name = var.user_list[1]
    path = var.user_path
    tags = var.user_tags

}

resource "aws_iam_user" "user3" {
    name = var.user_list[2]
    path = var.user_path
    tags = var.user_tags

}

----------------------------------------------------------------------------

resource "aws_iam_user" "user4" {
    name = var.user_any["z1"]
    path = var.user_path
    tags = var.user_tags

}


resource "aws_iam_user" "user5" {
    name = var.user_any["z2"][0]
    path = var.user_path
    tags = var.user_tags

}

resource "aws_iam_user" "user5" {
    name = var.user_any["z2"][1]
    path = var.user_path
    tags = var.user_tags

}

--------------------------------------------------------------------------