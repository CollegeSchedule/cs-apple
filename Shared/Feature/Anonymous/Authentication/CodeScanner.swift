import SwiftUI
import CodeScanner

struct CodeScanner: View {
	@Binding
	var isActive: Bool
	
    var body: some View {
		CodeScannerView(
			codeTypes: [.qr],
			completion: { result in
				if case let .success(code) = result {
					print(code)
					self.isActive = false
				}
			}
		)
    }
}
