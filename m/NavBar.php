<?php
namespace app\m;
use yii\db\ActiveRecord;

class  NavBar extends ActiveRecord
{
    static function tableName()
    {
        return "navbar";
    }
}