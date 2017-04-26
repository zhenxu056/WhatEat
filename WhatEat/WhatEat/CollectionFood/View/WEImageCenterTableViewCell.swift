//
//  WEImageCenterTableViewCell.swift
//  TodayToEat
//
//  Created by RuiTong_MAC on 17/4/19.
//  Copyright © 2017年 陈振旭. All rights reserved.
//

import UIKit

typealias buttonImageBlock = (UIImage)->()

class WEImageCenterTableViewCell: UITableViewCell { 
    
    var block: buttonImageBlock?
    var controller: UIViewController?
    
    let button: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named:"AlbumAddBtn"), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            button.addTarget(self, action: #selector(submitButtonAction(sender:)), for: .touchUpInside)
            self.contentView.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.size.equalTo(CGSize(width: 100, height: 100))
                make.center.equalTo(self.contentView)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WEImageCenterTableViewCell: UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func submitButtonAction(sender: UIButton) {
        let alertSheet = UIActionSheet(title: "请选择照片来源", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "相册")
        alertSheet.show(in: sender)
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                //设置代理
                picker.delegate = self
                //指定图片控制器类型
                picker.sourceType = UIImagePickerControllerSourceType.camera
                //设置是否允许编辑
                picker.allowsEditing = true
                //弹出控制器，显示界面
                controller?.present(picker, animated: true, completion: { 
                    
                })
            }
            break
        case 2:
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let picker = UIImagePickerController()
                //设置代理
                picker.delegate = self
                //指定图片控制器类型
                picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                //设置是否允许编辑
                picker.allowsEditing = true
                //弹出控制器，显示界面
                controller?.present(picker, animated: true, completion: {
                    
                })
            }
            break
            
        default: break
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image:UIImage!
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        button.setImage(image, for: .normal)
        picker.dismiss(animated: true, completion: {
            if self.block != nil {
                self.block!(image)
            }
        })
    }
}
