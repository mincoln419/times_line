package org.mermer.todoapi.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;
import org.mermer.todoapi.entity.enumeration.ContentType;
import org.mermer.todoapi.entity.enumeration.TaskStatus;


/**
 * QTodoItem is a Querydsl query type for TodoItem
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QTodoItem extends EntityPathBase<TodoItem> {

    private static final long serialVersionUID = 289199750L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QTodoItem todoItem = new QTodoItem("todoItem");

    public final QBaseEntity _super;

    public final StringPath contents = createString("contents");

    public final EnumPath<ContentType> contentType = createEnum("contentType", ContentType.class);

    //inherited
    public final DateTimePath<java.time.LocalDateTime> createAt;

    // inherited
    public final QTimeUser createdBy;

    public final QDailyTimeline dailyTimeline;

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final EnumPath<TaskStatus> taskStatus = createEnum("taskStatus", TaskStatus.class);

    public final StringPath title = createString("title");

    //inherited
    public final DateTimePath<java.time.LocalDateTime> updateAt;

    public QTodoItem(String variable) {
        this(TodoItem.class, forVariable(variable), INITS);
    }

    public QTodoItem(Path<? extends TodoItem> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QTodoItem(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QTodoItem(PathMetadata metadata, PathInits inits) {
        this(TodoItem.class, metadata, inits);
    }

    public QTodoItem(Class<? extends TodoItem> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this._super = new QBaseEntity(type, metadata, inits);
        this.createAt = _super.createAt;
        this.createdBy = _super.createdBy;
        this.dailyTimeline = inits.isInitialized("dailyTimeline") ? new QDailyTimeline(forProperty("dailyTimeline"), inits.get("dailyTimeline")) : null;
        this.updateAt = _super.updateAt;
    }

}

