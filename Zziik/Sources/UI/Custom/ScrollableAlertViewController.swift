////
////  ScrollableAlertViewController.swift
////  Zziik
////
////  Created by 구태호 on 2023/07/06.
////
//
//import UIKit
//import SnapKit
//import Then
//
//
//class ScrollableAlertViewController: BaseViewController {
//    lazy var foregroundView = UIView(frame: .zero).then {
//        $0.cornerRadius = 8
//        $0.backgroundColor = .init(resource: .FFFFFF)
//        $0.addSubviews(scrollView, buttonStackView)
//    }
//    
//    lazy var scrollView = CommonResizingScrollView().then {
//        $0.showsVerticalScrollIndicator = false
//        $0.bounces = false
//        $0.addSubviews(containerStackView)
//    }
//    
//    lazy var containerStackView = UIStackView(axis: .vertical, subviews: [ivDialogImage, lottieImageView, contentStackView])
//    
//    lazy var ivDialogImage = UIImageView().then {
//        $0.contentMode = .scaleAspectFill
//    }
//    
//    lazy var lottieImageView = UIView()
//    
//    lazy var contentStackView = UIStackView(axis: .vertical, spacing: 16, padding: .init(all: 20), subviews: [titleStackView, dialogTextView, checkBoxContainerStackView])
//    
//    lazy var titleStackView = UIStackView(axis: .horizontal, alignment: .top, subviews: [lbTitle]).then {
//        $0.hidden()
//    }
//    
//    lazy var lbTitle = UILabel().then {
//        $0.numberOfLines = 2
//        $0.font(type: .regular400, size: 20, color: .init(resource: ._212121))
//    }
//    
//    lazy var dialogTextView = CommonTextView().then {
//        $0.isScrollEnabled = false
//        $0.layoutMargins.top = 16
//        $0.isUserInteractionEnabled = false
//    }
//    
//    lazy var buttonStackView = UIStackView(axis: .horizontal, spacing: 1, alignment: .fill, distribution: .fillEqually, padding: .init(top: 1, leading: 0, bottom: 0, trailing: 0), subviews: [
//        btCancel, btSubmit
//    ]).then {
//        $0.backgroundColor = .accentGray
//    }
//    
//    lazy var btCancel = UIButton(configuration: .filled()).then {
//        $0.configuration?.baseForegroundColor = .primaryWhite
//        $0.configuration?.baseBackgroundColor = .primaryGray
//        $0.configuration?.attributedTitle = .styledText("취소", fontType: .regular, fontSize: 16, fontColor: .primaryWhite)
//        $0.configuration?.background.cornerRadius = 0
//        $0.hidden()
//    }
//    
//    lazy var btSubmit = UIButton(configuration: .filled()).then {
//        $0.configuration?.baseForegroundColor = .primaryWhite
//        $0.configuration?.baseBackgroundColor = .primaryGray
//        $0.configuration?.attributedTitle = .styledText("확인", fontType: .semiBold, fontSize: 16, fontColor: .primaryOrange)
//        $0.configuration?.background.cornerRadius = 0
//    }
//    
//    lazy var checkBoxContainerStackView = UIStackView(axis: .horizontal, spacing: 6, subviews: [checkBox, lbCheckBox])
//    lazy var checkBox = CommonCheckBox(state: .unchecked, markColor: .secondaryGray, boxColor: .secondaryGray, backgroundColor: .clear)
//    lazy var lbCheckBox = UILabel().then {
//        $0.text = "다시 보지 않기"
//        $0.textColor = .secondaryGray
//        $0.font = .systemFont(ofSize: 14, weight: .regular)
//    }
//    
//    var dialogImageUrl: String?
//    var dialogTitle: String?
//    var dialogContent: String
//    var cancelTitle: String?
//    var submitTitle: String?
//    
//    var seeAgainCompletion: (() -> ())?
//    var noticeCompletion: (() -> ())?
//    var cancelClosure: (() -> ())?
//    var submitClosure: (() -> ())?
//    
//    init(dialogContent: String) {
//        self.dialogContent = dialogContent
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        foregroundView.moveIn()
//    }
//    
//    override func initViews() {
//        view.addSubviews(foregroundView)
//        
//        scrollView.snp.makeConstraints {
//            $0.top.leading.trailing.equalToSuperview()
//        }
//        
//        containerStackView.snp.makeConstraints {
//            $0.width.equalToSuperview()
//            $0.edges.equalToSuperview()
//        }
//        
//        ivDialogImage.snp.makeConstraints {
//            $0.horizontalEdges.equalToSuperview()
//            $0.height.equalTo(ivDialogImage.snp.width)
//        }
//        
//        lottieImageView.snp.makeConstraints {
//            $0.horizontalEdges.equalToSuperview()
//            $0.height.equalTo(lottieImageView.snp.width)
//        }
//        
//        titleStackView.snp.makeConstraints {
//            $0.horizontalEdges.equalTo(contentStackView.layoutMarginsGuide)
//        }
//        
//        dialogTextView.snp.makeConstraints {
//            $0.horizontalEdges.equalTo(contentStackView.layoutMarginsGuide)
//        }
//        
//        ivNotice.snp.makeConstraints {
//            $0.size.equalTo(20)
//        }
//        
//        checkBoxContainerStackView.snp.makeConstraints {
//            $0.height.equalTo(20)
//        }
//        
//        checkBox.snp.makeConstraints {
//            $0.size.equalTo(20)
//        }
//        
//        buttonStackView.snp.makeConstraints {
//            $0.leading.bottom.trailing.equalToSuperview()
//            $0.top.equalTo(scrollView.snp.bottom)
//            $0.height.equalTo(54)
//        }
//    }
//    
//    override func initAttributes() {
//        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        
//        /* 썸네일 이미지 */
//        if let dialogImageUrl = dialogImageUrl, dialogImageUrl != "" {
//            ivDialogImage.urlImage(url: dialogImageUrl)
//            ivDialogImage.display()
//        } else {
//            ivDialogImage.hidden()
//        }
//        
//        /* 로티 이미지 */
//        if let lottieImageType = dialogLottieImageType {
//            lottieImageView.display()
//            lottieImageView.lottieImage(fileNames: lottieImageType)
//        } else {
//            lottieImageView.hidden()
//        }
//        
//        /* (?) 버튼 */
//        if noticeCompletion != nil {
//            titleStackView.display()
//            ivNotice.display()
//        }
//        
//        /* 제목 */
//        if let dialogTitle = dialogTitle.toOptionalIfEmpty {
//            titleStackView.display()
//            lbTitle.text = dialogTitle
//            lbTitle.layoutIfNeeded()
//        }
//        
//        dialogTextView.text = dialogContent
//        
//        if let cancelTitle = cancelTitle.toOptionalIfEmpty {
//            btCancel.display()
//            btCancel.configuration?.attributedTitle = .styledText(cancelTitle, fontType: .regular, fontSize: 16, fontColor: .primaryWhite)
//        }
//        
//        if seeAgainCompletion == nil {
//            checkBoxContainerStackView.hidden()
//        } else {
//            checkBoxContainerStackView.display()
//        }
//        
//        btSubmit.configuration?.attributedTitle = .styledText(submitTitle ?? "확인", fontType: .semiBold, fontSize: 16, fontColor: .primaryOrange)
//        scrollView.layoutIfNeeded()
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        let currentPopUpViewHeight = scrollView.contentSize.height
//        
//        let maxPopUpViewHeight = UIScreen.nativeHeight * (2 / 3)
//        
//        /* 팝업 최대 크기 제한 */
//        if maxPopUpViewHeight < currentPopUpViewHeight {
//            if isiPad {
//                foregroundView.snp.makeConstraints {
//                    $0.width.equalTo(UIScreen.nativeHeight / 3)
//                    $0.centerY.equalToSuperview()
//                    $0.height.equalTo(maxPopUpViewHeight)
//                }
//            } else {
//                foregroundView.snp.makeConstraints {
//                    $0.leading.trailing.equalToSuperview().inset(48)
//                    $0.centerY.equalToSuperview()
//                    $0.height.equalTo(maxPopUpViewHeight)
//                }
//            }
//        } else {
//            if isiPad {
//                foregroundView.snp.makeConstraints {
//                    $0.width.equalTo(UIScreen.nativeHeight / 3)
//                    $0.center.equalToSuperview()
//                }
//            } else {
//                foregroundView.snp.makeConstraints {
//                    $0.leading.trailing.equalToSuperview().inset(48)
//                    $0.centerY.equalToSuperview()
//                }
//            }
//        }
//    }
//    
//    override func initAction() {
//        // (?) 버튼
//        ivNotice.addAction { [weak self] in
//            self?.noticeCompletion?()
//        }
//        
//        btCancel.addAction { [weak self] in
//            self?.foregroundView.moveOut()
//            self?.dismiss(animated: true) {
//                self?.cancelClosure?()
//            }
//        }
//        
//        contentStackView.addAction { [weak self] in
//            self?.checkBox.toggleState()
//        }
//        
//        btSubmit.addAction { [weak self] in
//            self?.foregroundView.fadeOut()
//            
//            /// 다시 보지 않기 체크가 되어있을경우, 클로저 실행
//            if self?.checkBox.state == .checked {
//                self?.seeAgainCompletion?()
//            }
//            self?.dismiss(animated: true) {
//                self?.submitClosure?()
//            }
//        }
//    }
//}
