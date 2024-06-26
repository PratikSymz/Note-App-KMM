package com.plcoding.noteappkmm.android.note_list

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Search
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@Composable
fun HideableSearchTextField(
    modifier: Modifier = Modifier,
    text: String,
    isSearchActive: Boolean,
    onTextChange: (String) -> Unit,
    onSearchClick: () -> Unit,
    onCloseClick: () -> Unit
) {
    Box(modifier = modifier) {
        AnimatedVisibility(
            visible = isSearchActive,
            enter = fadeIn(),
            exit = fadeOut()
        ) {
            OutlinedTextField(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp)
                    .padding(end = 40.dp),
                value = text,
                onValueChange = onTextChange,
                shape = RoundedCornerShape(50.dp),
                placeholder = { Text(text = "Search") }
            )
        }

        AnimatedVisibility(
            modifier = Modifier.align(Alignment.CenterEnd),
            visible = isSearchActive,
            enter = fadeIn(),
            exit = fadeOut()
        ) {
            IconButton(
                onClick = onCloseClick
            ) {
                Icon(
                    imageVector = Icons.Default.Close,
                    contentDescription = "Close search"
                )
            }
        }

        AnimatedVisibility(
            modifier = Modifier.align(Alignment.CenterEnd),
            visible = !isSearchActive,
            enter = fadeIn(),
            exit = fadeOut()
        ) {
            IconButton(
                onClick = onSearchClick
            ) {
                Icon(
                    imageVector = Icons.Default.Search,
                    contentDescription = "Open search"
                )
            }
        }
    }
}