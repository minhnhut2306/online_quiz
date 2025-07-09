import 'package:flutter/material.dart';

typedef ItemBuilder =
    Widget Function(BuildContext context, Map<String, dynamic> item);

class PagedGrid extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final ItemBuilder itemBuilder;
  final int itemsPerPage;
  final int crossAxisCount;
  final double horizontalPadding;
  final double verticalPadding;
  final double bottomMargin;
  final double gridSpacing;

  const PagedGrid({
    required this.items,
    required this.itemBuilder,
    this.itemsPerPage = 10,
    this.crossAxisCount = 2,
    this.horizontalPadding = 12,
    this.verticalPadding = 16,
    this.bottomMargin = 24,
    this.gridSpacing = 8,
    super.key,
  });

  @override
  State<PagedGrid> createState() => _PagedGridState();
}

class _PagedGridState extends State<PagedGrid> {
  int currentPage = 1;

  int get totalPages =>
      (widget.items.length / widget.itemsPerPage).ceil().clamp(1, 9999);

  List<Map<String, dynamic>> get pagedItems {
    int start = (currentPage - 1) * widget.itemsPerPage;
    int end =
        (start + widget.itemsPerPage) > widget.items.length
            ? widget.items.length
            : (start + widget.itemsPerPage);
    return widget.items.sublist(start, end);
  }

  void setPage(int page) {
    setState(() {
      currentPage = page.clamp(1, totalPages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.horizontalPadding,
                  vertical: widget.verticalPadding,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: pagedItems.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.crossAxisCount,
                        crossAxisSpacing: widget.gridSpacing,
                        mainAxisSpacing: widget.gridSpacing,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder:
                          (context, index) =>
                              widget.itemBuilder(context, pagedItems[index]),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.only(bottom: 75),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PaginationButton(
                  icon: Icons.first_page,
                  onTap: currentPage > 1 ? () => setPage(1) : null,
                ),
                _PaginationButton(
                  icon: Icons.chevron_left,
                  onTap:
                      currentPage > 1 ? () => setPage(currentPage - 1) : null,
                ),
                for (int i = 1; i <= totalPages; i++)
                  _PaginationButton(
                    text: "$i",
                    isActive: i == currentPage,
                    onTap: i == currentPage ? null : () => setPage(i),
                  ),
                _PaginationButton(
                  icon: Icons.chevron_right,
                  onTap:
                      currentPage < totalPages
                          ? () => setPage(currentPage + 1)
                          : null,
                ),
                _PaginationButton(
                  icon: Icons.last_page,
                  onTap:
                      currentPage < totalPages
                          ? () => setPage(totalPages)
                          : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaginationButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool isActive;
  final VoidCallback? onTap;
  const _PaginationButton({
    this.text,
    this.icon,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.blue : Colors.grey[200],
          foregroundColor: isActive ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ), // tăng nhẹ padding
          minimumSize: const Size(36, 32), // tăng chút so với trước
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        child:
            icon != null
                ? Icon(icon, size: 17) // tăng icon lên 17
                : Text(
                  text ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ), // tăng lên 14
                ),
      ),
    );
  }
}
