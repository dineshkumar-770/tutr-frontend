// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
// import 'package:markdown/markdown.dart' as md;

// class MarkdownWidget extends StatelessWidget {
//   const MarkdownWidget({super.key, required this.text});
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return MarkdownBody(
//       data: text,
//       styleSheet: MarkdownStyleSheet(
//         p: const TextStyle(fontSize: 16, height: 1.6),
//         unorderedListAlign: WrapAlignment.start,
//         a: const TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
//         em: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
//         strong: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         del: const TextStyle(fontSize: 18, decoration: TextDecoration.lineThrough),
//         h1: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//         h2: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         h3: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         h4: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         h5: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         h6: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         code: const TextStyle(
//           backgroundColor: Color(0xFFEEEEEE),
//           fontFamily: 'Courier',
//           fontSize: 14,
//           color: Color(0xFF333333),
//         ),
//         codeblockDecoration: BoxDecoration(
//           color: Color(0xFFF8F8F8),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: Color(0xFFDDDDDD)),
//         ),
//         blockquote: const TextStyle(
//           fontStyle: FontStyle.italic,
//           color: Colors.teal,
//           fontSize: 16,
//         ),
//         blockquotePadding: const EdgeInsets.all(12),
//         blockquoteDecoration: BoxDecoration(
//           color: Color(0xFFE0F7FA),
//           border: Border(left: BorderSide(color: Colors.teal, width: 4)),
//         ),
//         tableHead: const TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//           backgroundColor: Colors.black87,
//         ),
//         tableBorder: TableBorder.all(color: Colors.grey),
//         horizontalRuleDecoration: const BoxDecoration(
//           border: Border(
//             top: BorderSide(width: 1.5, color: Colors.grey),
//           ),
//         ),
//         listBullet: const TextStyle(fontSize: 14),
//         listIndent: 24,
//       ),
//       builders: {
//         'latex': LatexElementBuilder(
//           textStyle: const TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//           ),
//           textScaleFactor: 1.25,
//         ),
//       },
//       extensionSet: md.ExtensionSet(
//         [
//           md.FencedCodeBlockSyntax(),
//           md.TableSyntax(),
//           md.BlockquoteSyntax(),
//           LatexBlockSyntax(),
//         ],
//         [
//           md.InlineHtmlSyntax(),
//           LatexInlineSyntax(),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_markdown/flutter_markdown.dart';
// // import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
// // import 'package:markdown/markdown.dart' as md;

// // class MarkdownWidget extends StatelessWidget {
// //   const MarkdownWidget({
// //     super.key,
// //     required this.text,
// //     this.width,
// //     this.height,
// //     this.fit = true,
// //   });

// //   final String text;
// //   final double? width;
// //   final double? height;
// //   final bool fit;

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       width: width,
// //       height: height,
// //       child: LayoutBuilder(
// //         builder: (context, constraints) {
// //           return SingleChildScrollView(
// //             child: ConstrainedBox(
// //               constraints: BoxConstraints(
// //                 minWidth: constraints.maxWidth,
// //                 minHeight: constraints.maxHeight,
// //               ),
// //               child: MarkdownBody(
// //                 data: text,
// //                 selectable: true,
// //                 styleSheet: MarkdownStyleSheet(
// //                   p: const TextStyle(fontSize: 16, height: 1.6),
// //                   unorderedListAlign: WrapAlignment.start,
// //                   a: const TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
// //                   em: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
// //                   strong: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   del: const TextStyle(fontSize: 18, decoration: TextDecoration.lineThrough),
// //                   h1: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
// //                   h2: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //                   h3: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// //                   h4: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                   h5: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   h6: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                   code: const TextStyle(
// //                     backgroundColor: Color(0xFFEEEEEE),
// //                     fontFamily: 'Courier',
// //                     fontSize: 14,
// //                     color: Color(0xFF333333),
// //                   ),
// //                   codeblockDecoration: BoxDecoration(
// //                     color: Color(0xFFF8F8F8),
// //                     borderRadius: BorderRadius.circular(8),
// //                     border: Border.all(color: Color(0xFFDDDDDD)),
// //                   ),
// //                   blockquote: const TextStyle(
// //                     fontStyle: FontStyle.italic,
// //                     color: Colors.teal,
// //                     fontSize: 16,
// //                   ),
// //                   blockquotePadding: const EdgeInsets.all(12),
// //                   blockquoteDecoration: BoxDecoration(
// //                     color: Color(0xFFE0F7FA),
// //                     border: Border(left: BorderSide(color: Colors.teal, width: 4)),
// //                   ),
// //                   tableHead: const TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                     backgroundColor: Colors.black87,
// //                   ),
// //                   tableBorder: TableBorder.all(color: Colors.grey),
// //                   horizontalRuleDecoration: const BoxDecoration(
// //                     border: Border(
// //                       top: BorderSide(width: 1.5, color: Colors.grey),
// //                     ),
// //                   ),
// //                   listBullet: const TextStyle(fontSize: 14),
// //                   listIndent: 24,
// //                 ),
// //                 builders: {
// //                   'latex': LatexElementBuilder(
// //                     textStyle: const TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 16,
// //                     ),
// //                     textScaleFactor: 1.25,
// //                   ),
// //                 },
// //                 extensionSet: md.ExtensionSet(
// //                   [
// //                     md.FencedCodeBlockSyntax(),
// //                     md.TableSyntax(),
// //                     md.BlockquoteSyntax(),
// //                     LatexBlockSyntax(),
// //                   ],
// //                   [
// //                     md.InlineHtmlSyntax(),
// //                     LatexInlineSyntax(),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
