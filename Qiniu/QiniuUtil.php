<?php
namespace Qiniu;
use Qiniu\Storage\UploadManager;

class QiniuUtil
{

    public $auth;
    public $bucket='videopro';// 要上传的空间
    public $token;
    function __construct()
    {
        $accessKey = 'OcULrbBFFoZIdVQod09kwaT2AUpso7AHecN6dRMb';
        $secretKey = '91P_hfHPjjPqthi7nochQcngicG7CKLnv1qbZ6fF';
        $this->auth = new Auth($accessKey, $secretKey);// 构建鉴权对象
        $this->token = $this->auth->uploadToken( $this->bucket);// 生成上传 Token

    }
    /*function uploadVImg($imgName,$imgFilePath) //上传视频图片
    {
        // 初始化 UploadManager 对象并进行文件的上传。
        $uploadMgr = new UploadManager();
        // 调用 UploadManager 的 putFile 方法进行文件的上传。

        list($ret, $err) = $uploadMgr->putFile($this->token, $imgName, $imgFilePath);

        if ($err !== null)
            return false;
        return true;

    }*/

    function uploadVImg($imgName,$imgFilePath) //上传视频图片
    {
        // 初始化 UploadManager 对象并进行文件的上传。
        $uploadMgr = new UploadManager();
        // 调用 UploadManager 的 putFile 方法进行文件的上传。
        //第四个参数就是上传策略构建数组
        $token=$this->auth->uploadToken( $this->bucket,null,3600,[
            //  "callbackUrl"=>"http://211.149.209.11:39192/web/video/imgcallback",
            "callbackUrl"=>"http://115.159.118.76:8500",
            "callbackBody"=>'key=$(key)',
            "mimeLimit"=>"image/jpeg;image/png"]);
        list($ret, $err) = $uploadMgr->putFile($token, $imgName, $imgFilePath);

        if ($err !== null)
            return false;
        return true;

    }

    /*function getUploadToken($userid)//生成视频上传专用token
    {
        $fileName="video".$userid.date("Ymdhis");//视频的文件名，暂时没有后缀
        $token=$this->auth->uploadToken( $this->bucket,null,3600,["saveKey"=>$fileName]);
        $res=new \stdClass();
        $res->uptoken=$token;
        return $res;
    }*/

    function getUploadToken($userid)//生成视频上传专用token
    {
        $fileName="video".$userid.date("Ymdhis");//视频的文件名，暂时没有后缀


        $token=$this->auth->uploadToken( $this->bucket,null,3600,
            ["saveKey"=>$fileName,
                //正式环境中一定要有回调   请看controllers/videocontroller的actionVideocallback方法
                //  "callbackUrl"=>"http://1307084f.nat123.net:39192/web/video/videocallback",
                "callbackUrl"=>"http://115.159.118.76:8500",
                "callbackBody"=>'key=$(key)'
                ,"mimeLimit"=>"video/mp4"]);
        $res=new \stdClass();
        $res->uptoken=$token;
        return $res;
    }

    function uploadVideo()
    {

    }
}