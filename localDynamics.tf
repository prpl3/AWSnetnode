# Here we generate some logical combinations for use in our terraform space
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

locals {
        principl3_alias = join( 
                        "-", compact([
                                var.whoami
                                ,var.environment
                                ,var.project_name
                                ]))

        principl3_tag = join( 
                        "/", compact([
                                data.aws_caller_identity.current.arn
                                ,var.environment
                                ,var.project_name
                                ]))

        deployed_by = join( 
                ",", compact(
                        [ replace( data.aws_caller_identity.current.arn, join(
                                "",[
                                "arn:aws:iam::"
                                ,data.aws_caller_identity.current.id
                                ,":user/"])
                        ,"")
                        ] 
                )
        )

# url = join( 
#         ".", compact(
#         [  join("-",compact( [ var.prpl3_deploy_prefix,  var.project.short_name]))
#         ,  var.prpl3_deploy_environment
#         ] 
#         )
# )
    
}
