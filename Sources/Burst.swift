//  Burst.swift
//
//  Created by patrick piemonte on 11/14/18.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2019-present patrick piemonte (http://patrickpiemonte.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import Foundation

/// 🎆 Burst, a Swift and easy way to apply a burst effect to UI elements
@MainActor
open class BurstView: UIView {
    
    // MARK: - properties
    
    /// Adjust the image used by each particle.
    public var particleImage: UIImage? {
        didSet {
            for cell in self._emitterCells {
                cell.contents = self.particleImage?.cgImage
            }
        }
    }
    
    /// Adjust the scale for each particle.
    public var particleScale: CGFloat = 0.05 {
        didSet {
            for cell in self._emitterCells {
                cell.scale = self.particleScale
            }
        }
    }
    
    /// Adjust the range of scale for each particle.
    public var particleScaleRange: CGFloat = 0.02 {
        didSet {
            for cell in self._emitterCells {
                cell.scaleRange = self.particleScaleRange
            }
        }
    }
    
    // MARK: - ivars
    
    private var _emitterCells: [CAEmitterCell] = []
    private lazy var _chargeLayer: CAEmitterLayer = {
        let chargeLayer = CAEmitterLayer()
        chargeLayer.name = "emitterLayer"
        chargeLayer.emitterShape = .circle
        chargeLayer.emitterMode = .outline
        chargeLayer.emitterSize = CGSize(width: 30, height: 0)
        chargeLayer.renderMode = .oldestFirst
        chargeLayer.masksToBounds = false
        return chargeLayer
    }()
    private lazy var _explosionLayer: CAEmitterLayer = {
        let explosionLayer = CAEmitterLayer()
        explosionLayer.name = "emitterLayer"
        explosionLayer.emitterShape = .circle
        explosionLayer.emitterMode = .outline
        explosionLayer.emitterSize = CGSize(width: 25, height: 0)
        explosionLayer.renderMode = .oldestFirst
        explosionLayer.masksToBounds = false
        explosionLayer.seed = 31337
        return explosionLayer
    }()
    
    // MARK: - object lifecycle
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        self._chargeLayer.emitterPosition = center
        self._explosionLayer.emitterPosition = center
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        if self.particleImage == nil {
            let frameworkBundle = Bundle(for: type(of: self))
            self.particleImage = UIImage(named: "burst-red", in: frameworkBundle, compatibleWith: nil)
        }
        
        self.clipsToBounds = false
        self.isUserInteractionEnabled = false
        
        let explosionCell = CAEmitterCell()
        explosionCell.name = "explosion"
        explosionCell.alphaRange = 0.20
        explosionCell.alphaSpeed = -1.0
        explosionCell.lifetime = 0.7
        explosionCell.lifetimeRange = 0.3
        explosionCell.birthRate = 0
        explosionCell.velocity = 40.00
        explosionCell.velocityRange = 10.00
        explosionCell.contents = self.particleImage?.cgImage
        explosionCell.scale = self.particleScale
        explosionCell.scaleRange = self.particleScaleRange
                
        self._explosionLayer.emitterCells = [explosionCell]
        self.layer.addSublayer(self._explosionLayer)
        
        let chargeCell = CAEmitterCell()
        chargeCell.name = "charge"
        chargeCell.alphaRange = 0.20
        chargeCell.alphaSpeed = -1.0
        chargeCell.lifetime = 0.3
        chargeCell.lifetimeRange = 0.1
        chargeCell.birthRate = 0
        chargeCell.velocity = -40.0
        chargeCell.velocityRange = 0.0
        chargeCell.contents = self.particleImage?.cgImage
        chargeCell.scale = self.particleScale
        chargeCell.scaleRange = self.particleScaleRange
        
        self._chargeLayer.emitterCells = [chargeCell]
        self.layer.addSublayer(self._chargeLayer)
        
        self._emitterCells = [chargeCell, explosionCell]
    }
    
    deinit {
        self._chargeLayer.removeFromSuperlayer()
        self._chargeLayer.emitterCells?.removeAll()
        
        self._explosionLayer.removeFromSuperlayer()
        self._explosionLayer.emitterCells?.removeAll()
        
        self._emitterCells.removeAll()
    }
    
}

// MARK: - actions

extension BurstView {

    private enum EmitterKeyPath {
        static let chargeBirthRate = "emitterCells.charge.birthRate"
        static let explosionBirthRate = "emitterCells.explosion.birthRate"
    }

    /// Start an effect.
    public func burst() {
        self._chargeLayer.beginTime = CACurrentMediaTime()
        self._chargeLayer.setValue(80, forKeyPath: EmitterKeyPath.chargeBirthRate)

        Task { @MainActor [weak self] in
            try? await Task.sleep(for: .milliseconds(200))
            self?.explode()
        }
    }

    /// Expand an explosion effect.
    public func explode() {
        self._chargeLayer.setValue(0, forKeyPath: EmitterKeyPath.chargeBirthRate)

        self._explosionLayer.beginTime = CACurrentMediaTime()
        self._explosionLayer.setValue(500, forKeyPath: EmitterKeyPath.explosionBirthRate)

        Task { @MainActor [weak self] in
            try? await Task.sleep(for: .milliseconds(100))
            self?.stop()
        }
    }

    /// Stop all effects.
    public func stop() {
        self._chargeLayer.setValue(0, forKeyPath: EmitterKeyPath.chargeBirthRate)
        self._explosionLayer.setValue(0, forKeyPath: EmitterKeyPath.explosionBirthRate)
    }

}

// MARK: - UIButton

/// Burst Button that emits when changing to a selected state.
@MainActor
open class BurstButton: UIButton {
    
    // MARK: - properties
    
    public var burstView: BurstView = BurstView(frame: .zero)
    
    open override var isSelected: Bool {
        didSet {
            if isSelected {
                self.animateToSelected(duration: 0.6)
                self.burstView.burst()
            } else {
                self.animateToUnselected(duration: 0.4)
            }
        }
    }
    
    // MARK: - layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.burstView.frame = self.bounds
        self.insertSubview(self.burstView, at: 0)
    }
    
    // MARK: - object lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.clipsToBounds = false
        self.burstView.frame = self.bounds
        self.insertSubview(self.burstView, at: 0)
    }
    
    deinit {
        self.burstView.stop()
    }
        
    // MARK: - animations
    
    public func animateToSelected(duration: TimeInterval) {
        transform = .identity
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: []) { [weak self] in
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
                self?.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                self?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }

    public func animateToUnselected(duration: TimeInterval) {
        transform = .identity
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: []) { [weak self] in
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
    
}
