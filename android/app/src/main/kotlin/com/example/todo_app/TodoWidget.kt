package com.example.todo_app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Color
import android.net.Uri
import android.util.TypedValue
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

/**
 * Android Home Screen Widget for The Bounty Board.
 * Features:
 * - Full multi-line task wrapping (no truncation with ...)
 * - Configurable dynamic font sizes (Small, Medium, Large, Extra Large)
 * - Real anime/Japanese wallpaper artwork with frosted glass scrim
 * - Real-time sync with in-app settings
 */
class TodoWidget : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId, widgetData)
        }
    }

    companion object {
        data class WidgetThemeConfig(
            val titleText: String,
            val wallpaperResId: Int,
            val scrimColor: Int,
            val btnResId: Int,
            val bulletResId: Int,
            val badgeColor: Int,
            val moreColor: Int
        )

        private fun getThemeConfig(themeId: String): WidgetThemeConfig {
            return when (themeId) {
                "naruto" -> WidgetThemeConfig(
                    titleText = "🍥 Ninja Scroll",
                    wallpaperResId = R.drawable.wp_naruto,
                    scrimColor = Color.parseColor("#C0200800"),
                    btnResId = R.drawable.btn_widget_naruto,
                    bulletResId = R.drawable.bullet_widget_naruto,
                    badgeColor = Color.parseColor("#FFFF9800"),
                    moreColor = Color.parseColor("#FFFF9800")
                )
                "demonslayer" -> WidgetThemeConfig(
                    titleText = "⚔️ Demon Slayer",
                    wallpaperResId = R.drawable.wp_demonslayer,
                    scrimColor = Color.parseColor("#C0200008"),
                    btnResId = R.drawable.btn_widget_demonslayer,
                    bulletResId = R.drawable.bullet_widget_demonslayer,
                    badgeColor = Color.parseColor("#FFFF4D6D"),
                    moreColor = Color.parseColor("#FFFF4D6D")
                )
                "jjk" -> WidgetThemeConfig(
                    titleText = "👁️ Cursed Energy",
                    wallpaperResId = R.drawable.wp_jjk,
                    scrimColor = Color.parseColor("#C0080015"),
                    btnResId = R.drawable.btn_widget_jjk,
                    bulletResId = R.drawable.bullet_widget_jjk,
                    badgeColor = Color.parseColor("#FFB565FF"),
                    moreColor = Color.parseColor("#FFB565FF")
                )
                "onepiece" -> WidgetThemeConfig(
                    titleText = "☠️ Pirate King",
                    wallpaperResId = R.drawable.wp_onepiece,
                    scrimColor = Color.parseColor("#C0001020"),
                    btnResId = R.drawable.btn_widget_onepiece,
                    bulletResId = R.drawable.bullet_widget_onepiece,
                    badgeColor = Color.parseColor("#FFFFD700"),
                    moreColor = Color.parseColor("#FFFFD700")
                )
                "sakura" -> WidgetThemeConfig(
                    titleText = "🌸 Sakura Board",
                    wallpaperResId = R.drawable.wp_sakura,
                    scrimColor = Color.parseColor("#80FFFFFF"),
                    btnResId = R.drawable.btn_widget_sakura,
                    bulletResId = R.drawable.bullet_widget_sakura,
                    badgeColor = Color.parseColor("#FFE91E8C"),
                    moreColor = Color.parseColor("#FFE91E8C")
                )
                "samurai" -> WidgetThemeConfig(
                    titleText = "🗡️ Bushido Board",
                    wallpaperResId = R.drawable.wp_samurai,
                    scrimColor = Color.parseColor("#C0100800"),
                    btnResId = R.drawable.btn_widget_samurai,
                    bulletResId = R.drawable.bullet_widget_samurai,
                    badgeColor = Color.parseColor("#FFD4AF37"),
                    moreColor = Color.parseColor("#FFD4AF37")
                )
                "tokyoneon" -> WidgetThemeConfig(
                    titleText = "🌆 Tokyo Neon",
                    wallpaperResId = R.drawable.wp_tokyoneon,
                    scrimColor = Color.parseColor("#B8000510"),
                    btnResId = R.drawable.btn_widget_tokyoneon,
                    bulletResId = R.drawable.bullet_widget_tokyoneon,
                    badgeColor = Color.parseColor("#FF00E5FF"),
                    moreColor = Color.parseColor("#FF00E5FF")
                )
                "forest" -> WidgetThemeConfig(
                    titleText = "🌿 Forest Spirit",
                    wallpaperResId = R.drawable.wp_forest,
                    scrimColor = Color.parseColor("#90001000"),
                    btnResId = R.drawable.btn_widget_forest,
                    bulletResId = R.drawable.bullet_widget_forest,
                    badgeColor = Color.parseColor("#FF4CAF50"),
                    moreColor = Color.parseColor("#FF4CAF50")
                )
                "inkwash" -> WidgetThemeConfig(
                    titleText = "🖌️ Ink Wash",
                    wallpaperResId = R.drawable.wp_inkwash,
                    scrimColor = Color.parseColor("#60F8F8F4"),
                    btnResId = R.drawable.btn_widget_inkwash,
                    bulletResId = R.drawable.bullet_widget_inkwash,
                    badgeColor = Color.parseColor("#FF37474F"),
                    moreColor = Color.parseColor("#FF37474F")
                )
                else -> WidgetThemeConfig(
                    titleText = "🏴 Bounty Board",
                    wallpaperResId = R.drawable.wp_midnight,
                    scrimColor = Color.parseColor("#A8000000"),
                    btnResId = R.drawable.btn_widget_midnight,
                    bulletResId = R.drawable.bullet_widget_midnight,
                    badgeColor = Color.parseColor("#FFA894E6"),
                    moreColor = Color.parseColor("#FFA894E6")
                )
            }
        }

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int,
            widgetData: SharedPreferences
        ) {
            val views = RemoteViews(context.packageName, R.layout.todo_widget)

            // Open app on widget tap
            val openAppIntent = HomeWidgetLaunchIntent.getActivity(
                context, MainActivity::class.java
            )
            views.setOnClickPendingIntent(R.id.widget_root, openAppIntent)

            // (+) button opens Add Bounty sheet
            val addTaskIntent = HomeWidgetLaunchIntent.getActivity(
                context, MainActivity::class.java, Uri.parse("todoApp://addTask")
            )
            views.setOnClickPendingIntent(R.id.btn_add_task, addTaskIntent)

            // ── Apply Theme ──────────────────────────────────────────────
            val themeId = widgetData.getString("theme_id", "midnight") ?: "midnight"
            val theme = getThemeConfig(themeId)

            // Set PNG wallpaper artwork
            views.setImageViewResource(R.id.img_wallpaper, theme.wallpaperResId)

            // Tint scrim overlay
            views.setInt(R.id.scrim_overlay, "setBackgroundColor", theme.scrimColor)

            // Themed button + bullet drawables
            views.setInt(R.id.btn_add_task, "setBackgroundResource", theme.btnResId)

            // Themed title
            views.setTextViewText(R.id.tv_widget_title, theme.titleText)

            // ── Read Font Size ───────────────────────────────────────────
            val fontSizeSp = widgetData.getInt("font_size_sp", 13).toFloat()

            // ── Read task data ───────────────────────────────────────────
            val taskTitlesRaw = widgetData.getString("task_titles", "") ?: ""
            val activeCount = widgetData.getInt("active_count", 0)

            val titles = if (taskTitlesRaw.isNotBlank()) {
                taskTitlesRaw.split("|").filter { it.isNotBlank() }
            } else emptyList()

            // Header badge
            if (activeCount > 0) {
                views.setTextViewText(R.id.tv_widget_badge, " ($activeCount)")
                views.setTextColor(R.id.tv_widget_badge, theme.badgeColor)
                views.setViewVisibility(R.id.tv_widget_badge, View.VISIBLE)
            } else {
                views.setViewVisibility(R.id.tv_widget_badge, View.GONE)
            }

            // Empty / task list toggle
            if (titles.isEmpty()) {
                views.setTextViewTextSize(R.id.tv_empty, TypedValue.COMPLEX_UNIT_SP, fontSizeSp)
                views.setViewVisibility(R.id.tv_empty, View.VISIBLE)
                views.setViewVisibility(R.id.task_container, View.GONE)
            } else {
                views.setViewVisibility(R.id.tv_empty, View.GONE)
                views.setViewVisibility(R.id.task_container, View.VISIBLE)

                val rowIds = intArrayOf(
                    R.id.task_row_1, R.id.task_row_2, R.id.task_row_3,
                    R.id.task_row_4, R.id.task_row_5
                )
                val textIds = intArrayOf(
                    R.id.task_text_1, R.id.task_text_2, R.id.task_text_3,
                    R.id.task_text_4, R.id.task_text_5
                )
                val bulletIds = intArrayOf(
                    R.id.task_bullet_1, R.id.task_bullet_2, R.id.task_bullet_3,
                    R.id.task_bullet_4, R.id.task_bullet_5
                )

                for (i in 0 until 5) {
                    if (i < titles.size) {
                        views.setTextViewText(textIds[i], titles[i])
                        views.setTextViewTextSize(textIds[i], TypedValue.COMPLEX_UNIT_SP, fontSizeSp)
                        views.setImageViewResource(bulletIds[i], theme.bulletResId)
                        views.setViewVisibility(rowIds[i], View.VISIBLE)
                    } else {
                        views.setViewVisibility(rowIds[i], View.GONE)
                    }
                }

                val extraCount = widgetData.getInt("extra_count", 0)
                if (extraCount > 0) {
                    views.setTextViewText(R.id.tv_more_tasks, "+ $extraCount more in app...")
                    views.setTextViewTextSize(R.id.tv_more_tasks, TypedValue.COMPLEX_UNIT_SP, (fontSizeSp - 2f).coerceAtLeast(10f))
                    views.setTextColor(R.id.tv_more_tasks, theme.moreColor)
                    views.setViewVisibility(R.id.tv_more_tasks, View.VISIBLE)
                } else {
                    views.setViewVisibility(R.id.tv_more_tasks, View.GONE)
                }
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
