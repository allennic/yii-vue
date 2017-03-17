<?php
namespace app\m;

use yii\db\ActiveRecord;

class News extends ActiveRecord
{
    public static  function tableName()
    {
        return 'news';
    }

    function getNewsClass(){
        return $this->hasOne(NewsClass::className(),["class_id"=>"news_classid"]);
    }
}