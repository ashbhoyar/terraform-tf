variable "user_name" {
    type = string
    default = "laxman"

}

variable "user_path" {
    type = string
    default = "/"

}

variable "user_list" {
    type = list
    default = ["a1", "a2","a3"]


}

variable "user_tags" {
    type = map
    default = {
        project = "Ecom1"
        team = "Devops"
        type = "infra"
    }

}

--------------------------------------------------------------------------

variable "user_any" {
    type = any
    default = {
        z1 = "xyz"
        z2 = ["x1","x2"]
        z3 = 500 
    }
}

--------------------------------------------------------------------------

