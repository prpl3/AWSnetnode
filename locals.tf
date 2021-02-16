# Here we generate some logical combinations for use in our terraform space
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

locals {

        vpc_name = join( 
                        "-", compact([
                                var.whoami,
                                replace(var.principl3_tld,".","-"),
                                "demo-vpc"
                                ]))

        vpc_url = join( 
                        ".", compact([
                                var.whoami,
                                var.aws_region,
                                var.principl3_tld
                                ]))

        storage_name = join( 
                        "-", compact([
                                "s3",
                                var.aws_region,
                                var.whoami,
                                replace(var.storage_tld,".","-"),
                                ]))
        storage_url = join( 
                        ".", compact([
                                "s3",
                                var.aws_region,
                                var.whoami,
                                var.storage_tld,
                                ]))

        instance_url = join( 
                        ".", compact([
                                var.whoami,
                                var.aws_region,
                                var.storage_tld,
                                ]))

        principl3_tag = join( 
                        "/", compact([
                                data.aws_caller_identity.current.arn,
                                replace(local.vpc_name,"-",":")
                                ]))

        deployed_by = join( 
                ",", compact(
                        [ replace( data.aws_caller_identity.current.arn, join(
                                "",[
                                "arn:aws:iam::",
                                data.aws_caller_identity.current.id,
                                ":user/"])
                        ,"")
                        ] 
                )
        )    
}
