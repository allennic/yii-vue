<?php
namespace app\m;
use yii\db\ActiveRecord;

class ModelFactory extends ActiveRecord
{
    private static $_tableName;
    public static function tableName()
    {
        return self::$_tableName;
    }
    public static function loadModel($tableName)
    {
        self::$_tableName=$tableName;
        return new ModelFactory();
    }
}