# CLI CMDS

## S3

- List bucket - `aws s3 ls`

- List objects - `aws s3 ls s3://bucket-name --recurisve`

- Download File - `aws s3 cp s3://<bucketName> .`

- move files `aws s3 mv <source> <destination>`

- create bucket `aws s3 mb s3://<bucketname>`

- delete bucket `aws s3 rb s3://<bucketName>`

- delete object `aws s3 rm s3://<location>`

- upload file `aws s3 cp <localfile> s3://<destination>`

- upload directory - `aws s3 cp ./build s3://my-bucket --recursive`

- Sync Directory - `aws s3 sync ./build s3://my-bucket`

- Delete removed file too - `aws s3 sync ./dist s3://frontend-bucket --delete`

- view bucket location - `aws s3api get-bucket-location --bucket my-bucket`

- Enable versioning - `aws s3api put-bucket-versioning --bucket my-bucket --versioning-configuration Status=Enabled`

- view bucket policy - `aws s3api get-bucket-policy --bucket my-bucket`

- view public access block - `aws s3api get-public-access-block --bucket my-bucket`
