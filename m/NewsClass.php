<?php
namespace app\m;

use yii\db\ActiveRecord;

class NewsClass extends ActiveRecord
{
    public static  function tableName()
    {
        return 'news_class';
    }
}