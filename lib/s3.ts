import AWS from 'aws-sdk';

let s3: AWS.S3;

declare global {
    // allow global `var` declarations
    // eslint-disable-next-line no-var
    var s3: AWS.S3 | undefined;
}

if (!global.s3) {
    global.s3 = new AWS.S3({
        accessKeyId: process.env.S3_ACCESS_KEY_ID,
        secretAccessKey: process.env.S3_SECRET_ACCESS_KEY,
        region: process.env.S3_REGION,
    });
}
// eslint-disable-next-line prefer-const
s3 = global.s3;

export default s3;
