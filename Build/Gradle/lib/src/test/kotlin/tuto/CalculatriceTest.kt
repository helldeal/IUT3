package tuto

import org.junit.jupiter.api.Test
import kotlin.test.assertEquals

class CalculatriceTest {

    @Test
    fun add() {
        assertEquals(Calculatrice().add(1,1),2)
        assertEquals(Calculatrice().add(5,8),13)
    }
}