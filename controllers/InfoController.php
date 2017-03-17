<?php
/**
 * Created by PhpStorm.
 * User: erb398wei
 * Date: 2017/2/26
 * Time: 17:32
 */

namespace app\controllers;


use yii\filters\auth\QueryParamAuth;
use yii\rest\ActiveController;

class InfoController extends ActiveController
{
    public $modelClass = 'app\m\News';

    public function init()
    {
        parent::init();
        \Yii::$app->user->enableSession = false;
    }

    public function behaviors()
    {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => QueryParamAuth::className(),
        ];
        return $behaviors;
    }


}