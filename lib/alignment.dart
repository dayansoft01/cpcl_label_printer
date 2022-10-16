enum CpclPrintAlignment { center, left, right }

extension SeasonExtension on CpclPrintAlignment {
  ///扩展方法，为枚举的value方法
  /// this会作为扩展的方法参数传递，此处的index，是this.index的简写
  String get value => [
        'CENTER',
        'LEFT',
        'RIGHT',
      ][index];
}
