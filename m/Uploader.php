<?php
namespace app\m;
use Qiniu\QiniuUtil;
use yii\base\Model;

class  Uploader extends Model
{
    public $imageFile;

    public function rules()
    {
        return [
            [['imageFile'], 'file', 'skipOnEmpty' => false, 'extensions' => 'png,jpg'],
        ];
    }

    /*public function upload()
    {
        $userid="0";//后面再做，用户的ID，默认0，代表超级管理员
        $imgName=date('Ymdhis').$userid;
        if ($this->validate()) {

            $this->imageFile->saveAs('images/videos/' . $imgName . '.' . $this->imageFile->extension);
            return $imgName;
        } else {
            return false;
        }
    }*/

    public function upload()
    {
        $result=new \stdClass();
        $result->name="";
        $result->status=0;
        $result->url="";
        $result->id=0;


        $userid="0";//后面再做，用户的ID，默认0，代表超级管理员
        $imgName=date('Ymdhis').$userid. '.' . $this->imageFile->extension;
        if ($this->validate()) {

            $vi=ModelFactory::loadModel("videos_img");
            $vi->img_name=$imgName;
            $vi->img_url="http://omuud2oh3.bkt.clouddn.com/".$vi->img_name;


            if($vi->save())//数据库插值成功
            {
                $qutil=new QiniuUtil();
                $img_filePath='images/videos/'. $vi->img_name;//图片保存的真实物理路径

                $this->imageFile->saveAs($img_filePath);//保存到 真实文件路径
                if($qutil->uploadVImg($vi->img_name,$img_filePath))//上传到七牛
                {
                    $result->name=$vi->img_name;
                    $result->url=$vi->img_url;
                    $result->id=$vi->img_id;//主键
                    $result->status=1;
                    return json_encode($result); //成功了，返回json结果
                }
            }
        }
        return json_encode($result);
    }
}