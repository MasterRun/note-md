# RecyclerView 拖拽删除

使用RecyclerView实现拖拽排序，拖拽到底部删除

```kotlin
object DragRvHelper {
    @JvmStatic
    fun addMask(activity: Activity?, aboveView: View) {
        if (activity == null) {
            return
        }
        aboveView.post {
            //上方view的高度
            val height = aboveView.height
            val aboveViewLocation = IntArray(2)
            //上方的view在屏幕中的y
            aboveView.getLocationOnScreen(aboveViewLocation)
            //window的上边距
            val marginTop = height + aboveViewLocation[1]
            //获取windowsize, todo 处理底部导航栏高度
            val windowSize = Point()
            activity.windowManager.defaultDisplay.getSize(windowSize)
            val topMessageWindow = TopMessageWindow(activity, mHeight = windowSize.y - marginTop)
            topMessageWindow.showAsDropDown(aboveView)
        }
    }

}

class TopMessageWindow(activity: Activity, mWidth: Int = ViewGroup.LayoutParams.MATCH_PARENT, mHeight: Int = ViewGroup.LayoutParams.MATCH_PARENT) : PopupWindow() {
    val messageTopWindowBinding: MessageTopWindowBinding

    var deleteYPosition: Int = Int.MAX_VALUE

    var count = 15

    init {
        messageTopWindowBinding = MessageTopWindowBinding.inflate(LayoutInflater.from(activity))
        contentView = messageTopWindowBinding.root

        messageTopWindowBinding.tvDelete.post {
            deleteYPosition = IntArray(2).apply {
                messageTopWindowBinding.tvDelete.getLocationInWindow(this)
            }[1]
        }

        width = mWidth
        height = mHeight

        isFocusable = true
        isOutsideTouchable = true
        update()

        setBackgroundDrawable(ColorDrawable(Color.parseColor("#aaf1f1f1")))

        //设置adapter
        messageTopWindowBinding.rv.adapter = object : RecyclerView.Adapter<RecyclerView.ViewHolder>() {
            override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
                return object : RecyclerView.ViewHolder(FrameLayout(parent.context).apply {
                    isClickable = true
                    isLongClickable = true
                    isFocusableInTouchMode = true
                    setBackgroundColor(Color.RED)
                    layoutParams = ViewGroup.MarginLayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 200).apply {
                        setMargins(15, 15, 15, 15)
                    }
                    addView(TextView(context).apply {
                        tag = "messageItem"
                        setTextColor(Color.WHITE)
                        gravity = Gravity.CENTER
                    }, ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
                }) {}
            }

            override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
                //最后一个设置为黄色
                if (position == (count - 1)) {
                    holder.itemView.setBackgroundColor(Color.YELLOW)
                } else {
                    holder.itemView.findViewWithTag<TextView>("messageItem").text = "当前是$position"
                }
            }

            override fun getItemCount(): Int {
                return count
            }
        }

        //使用itemtouchhelper
        val itemTouchHelper = ItemTouchHelper(object : ItemTouchHelper.Callback() {
            /**
             * 获取拖拽标识，可向那些方向拖拽
             */
            override fun getMovementFlags(recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder): Int {
                return if (recyclerView.layoutManager is GridLayoutManager) {
                    val dragFlags = ItemTouchHelper.UP or ItemTouchHelper.DOWN or ItemTouchHelper.LEFT or ItemTouchHelper.RIGHT
                    val swipeFlags = 0
                    makeMovementFlags(dragFlags, swipeFlags)
                } else {
                    val dragFlags = ItemTouchHelper.UP or ItemTouchHelper.DOWN
                    val swipeFlags = 0
                    makeMovementFlags(dragFlags, swipeFlags)
                }
            }

            var fingerUp = false;

            override fun onChildDraw(c: Canvas, recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder, dX: Float, dY: Float, actionState: Int, isCurrentlyActive: Boolean) {
                val y = viewHolder.itemView.run {
                    val position = IntArray(2)
                    getLocationInWindow(position)
                    position[1] + this.height
                }

                if (y >= deleteYPosition) {
                    messageTopWindowBinding.tvDelete.setTextColor(Color.RED)
                    if (!isCurrentlyActive) {
                        val adapterPosition = viewHolder.adapterPosition
                        if (fingerUp) {
                            //先设置不可见，如果不设置的话，会看到viewHolder返回到原位置时才消失，因为remove会在viewHolder动画执行完成后才将viewHolder删除
                            viewHolder.itemView.visibility = View.INVISIBLE
                            count--
                            recyclerView.adapter?.notifyItemRemoved(adapterPosition)
                            fingerUp = false
                            return
                        }
                    }
                } else {
                    messageTopWindowBinding.tvDelete.setTextColor(Color.BLUE)
                }

                super.onChildDraw(c, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive)                // item 的 y 坐标 + 高度
            }

            override fun onChildDrawOver(c: Canvas, recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder?, dX: Float, dY: Float, actionState: Int, isCurrentlyActive: Boolean) {
                super.onChildDrawOver(c, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive)
            }

            /**
             * 放开手指后会调用此方法，拿到item回到终点的动画
             */
            override fun getAnimationDuration(recyclerView: RecyclerView, animationType: Int, animateDx: Float, animateDy: Float): Long {
                fingerUp = true
                return super.getAnimationDuration(recyclerView, animationType, animateDx, animateDy)
            }

            /**
             * 移动回调，可用于处理数据、adapter notify
             */
            override fun onMove(recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder, target: RecyclerView.ViewHolder): Boolean {
                //得到当拖拽的viewHolder的Position
                val fromPosition = viewHolder.adapterPosition
                //拿到当前拖拽到的item的viewHolder
                val toPosition = target.adapterPosition

                //忽略最后一个item
                if (toPosition == count - 1 || fromPosition == count - 1) {
                    return true;
                }
                //调整数据
/*                if (fromPosition < toPosition) {
                    for (i in fromPosition until toPosition) {
                        Collections.swap(list, i, i + 1)
                    }
                } else {
                    for (i in fromPosition downTo toPosition + 1) {
                        Collections.swap(list, i, i - 1)
                    }
                }*/
                // 视觉效果 item 交换，使用notifyItemMoved，不调用则不交换
                recyclerView.adapter?.notifyItemMoved(fromPosition, toPosition)
                return true
            }

            override fun onSwiped(viewHolder: RecyclerView.ViewHolder, direction: Int) {
            }


            /**
             * 长按选中Item的时候开始调用
             */
            override fun onSelectedChanged(viewHolder: RecyclerView.ViewHolder?, actionState: Int) {
                if (actionState != ItemTouchHelper.ACTION_STATE_IDLE) {
                    viewHolder?.itemView?.setBackgroundColor(Color.LTGRAY);
                }
                super.onSelectedChanged(viewHolder, actionState)
            }

            /**
             * 手指松开item回到终点位置
             */
            override fun clearView(recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder) {
                super.clearView(recyclerView, viewHolder)
                fingerUp = false
                viewHolder.itemView.setBackgroundColor(Color.RED)
            }

            override fun isLongPressDragEnabled(): Boolean {
                //此处设置为false，在 RecyclerView 中重写item的相关触摸事件，自定义指定哪些 item 可以拖拽
                return false
            }
        })
        itemTouchHelper.attachToRecyclerView(messageTopWindowBinding.rv)

        messageTopWindowBinding.rv.run {
            //添加recyclerview的item触摸事件
            addOnItemTouchListener(object : OnRecyclerItemClickListener(this) {
                override fun onItemClick(vh: RecyclerView.ViewHolder) {
                }

                override fun onItemLongClick(vh: RecyclerView.ViewHolder) {
                    //长按的不是最后一个，开始拖拽
                    if (vh.layoutPosition != count - 1) {
                        itemTouchHelper.startDrag(vh)
                    }
                }
            })
        }
    }

    /**
     * 自定义处理item的触摸事件，分发点击和长按
     */
    abstract class OnRecyclerItemClickListener(private val recyclerView: RecyclerView) : RecyclerView.OnItemTouchListener {

        private val mGestureDetector: GestureDetectorCompat

        init {
            mGestureDetector = GestureDetectorCompat(recyclerView.context, ItemTouchHelperGestureListener())
        }

        override fun onInterceptTouchEvent(rv: RecyclerView, e: MotionEvent): Boolean {
            mGestureDetector.onTouchEvent(e)
            return false
        }

        override fun onTouchEvent(rv: RecyclerView, e: MotionEvent) {
            mGestureDetector.onTouchEvent(e)
        }

        override fun onRequestDisallowInterceptTouchEvent(disallowIntercept: Boolean) {}

        private inner class ItemTouchHelperGestureListener : GestureDetector.SimpleOnGestureListener() {
            override fun onSingleTapUp(e: MotionEvent): Boolean {
                val child = recyclerView.findChildViewUnder(e.x, e.y)
                if (child != null) {
                    val vh = recyclerView.getChildViewHolder(child)
                    onItemClick(vh)
                }
                return true
            }

            override fun onLongPress(e: MotionEvent) {
                val child = recyclerView.findChildViewUnder(e.x, e.y)
                if (child != null) {
                    val vh = recyclerView.getChildViewHolder(child)
                    onItemLongClick(vh)
                }
            }
        }

        abstract fun onItemClick(vh: RecyclerView.ViewHolder)
        abstract fun onItemLongClick(vh: RecyclerView.ViewHolder)
    }
}
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:clipChildren="false">

    <!-- clipChildren 允许子view超出父view而不被裁剪 -->

<TextView
        android:id="@+id/tv_delete"
        android:layout_width="match_parent"
        android:layout_height="40dp"
        android:layout_gravity="bottom"
        android:background="@color/white"
        android:gravity="center"
        android:text="拖到此处取消置顶" />

    <androidx.recyclerview.widget.RecyclerView
        android:id="@+id/rv"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:clipChildren="false"
        android:background="@color/card_indicator_unselected_white"
        android:clipToPadding="false"
        app:layoutManager="androidx.recyclerview.widget.GridLayoutManager"
        app:spanCount="5"
        tools:itemCount="15" />
</FrameLayout>
```
