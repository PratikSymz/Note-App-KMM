package com.plcoding.noteappkmm.domain.note

import com.plcoding.noteappkmm.presentation.BabyBlueHex
import com.plcoding.noteappkmm.presentation.LightGreenHex
import com.plcoding.noteappkmm.presentation.RedOrangeHex
import com.plcoding.noteappkmm.presentation.RedPinkHex
import com.plcoding.noteappkmm.presentation.VioletHex
import kotlinx.datetime.LocalDateTime

data class Note(
    val id: Long?,
    val title: String,
    val content: String,
    val colorHex: Long,
    val created: LocalDateTime
) {
    companion object {
        private val colors = listOf(RedOrangeHex, RedPinkHex, LightGreenHex, BabyBlueHex, VioletHex)

        fun generateRandomColor() = colors.random()
    }
}
